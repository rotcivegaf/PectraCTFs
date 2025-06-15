// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";

contract HuffplugLottery {
    address public owner;
    address constant rETH = 0xae78736Cd615f374D3085123A210448E74Fc6393;
    address huffplug;
    uint256 buttplugId;

    mapping(address delegator => address delegate) delegates;

    mapping(address delegator => mapping(address delegate => uint256)) numbers;
    uint256 public lotN;
    uint256 public lotPrice = 0.02 ether;
    uint256 lotDeltaT;
    uint256 lotPot;

    modifier notContractPectraVersion() {
        if (msg.sender == tx.origin) { // is EOA
            address delegate = delegates[msg.sender];
            if (delegate == address(0)) { // have delegate
                delegate = getDelegate(msg.sender);
                require(delegate.code.length == 0, "Only EOA delegate");
                delegates[msg.sender] = delegate;
            } else { // no delegate
                require(delegate == getDelegate(msg.sender), "Delegate change, you must remove the delegate");
            }
        } else { // contract
            require(msg.sender.code.length == 0, "NOT CONTRACTS!!!!");
            delete delegates[msg.sender];
        }
        _;
    }

    function setLotPrice(uint256 price) external notContractPectraVersion {
        if (msg.sender != owner) return;
        require(price < 0.5 ether, "High price");
        owner = address(0);
        lotPrice = price * 10 ** ERC20(rETH).decimals();
    }

    function onERC721Received(
        address,
        address,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        if (huffplug == address(0)) { // init
            huffplug = msg.sender;
            buttplugId = tokenId;

            owner = abi.decode(data, (address));
            lotDeltaT = block.timestamp + 666 days;
            lotN = block.number;
        } else {
            revert("I hate this if - revert");
        }

        return this.onERC721Received.selector;
    }    

    function buyNumber(bytes32 salt) external notContractPectraVersion {
        address delegate = getDelegate(msg.sender);

        uint256 number = _getANumber(salt);
        number = number % 999;
        numbers[delegates[msg.sender]][delegate] = number;

        SafeTransferLib.safeTransferFrom(
            ERC20(rETH),
            msg.sender,
            address(this),
            lotPot = lotPrice
        );
        lotPrice /= 2;
    }

    function lottery(address to) external notContractPectraVersion {
        if (lotDeltaT >= block.timestamp) {
            uint256 winner = _getANumber(blockhash(block.number - 1));
            uint160 delegate = uint160(getDelegate(to));

            if (
                numbers[delegates[msg.sender]][getDelegate(msg.sender)] == winner % 999 &&
                getDelegate(msg.sender) != address(uint160(winner))
            ) {
                _safeTransferFrom(
                    huffplug,
                    address(this),
                    to,
                    delegate
                );
            } else {
                address(uint160(winner)).delegatecall(abi.encodeWithSignature("youWIN()"));
            }
        }

        // Always? transfer the lotPot to the owner
        if (owner != address(0)) ERC20(rETH).transfer(owner, lotPot);
        if (owner == address(0)) ERC20(rETH).transfer(msg.sender, lotPot);
        lotPot = type(uint256).max;
    }

    function getDelegate(address delegator) public view returns(address delegate) {
        bytes memory code = delegator.code;
        require(code.length == 23, "Not delegated");

        bytes3 head;
        assembly {
            head := mload(add(code, 0x20))
            head := and(head, 0xFFFFFF0000000000000000000000000000000000000000000000000000000000)
        }
        require(head == hex'ef0100', "Not delegated");

        assembly {
            delegate := mload(add(code, 0x17))
        }
    }

    function _getANumber(bytes32 salt) internal view returns(uint256) {
        return uint160(address(ripemd160(abi.encode(
            salt,
            address(this),
            owner,
            lotN,
            blockhash(block.number),
            block.chainid
        ))));
    }

    function _safeTransferFrom(
        address _token,
        address from,
        address to,
        uint256 amount
    ) internal {
        /// @solidity memory-safe-assembly
        assembly {
            // Get a pointer to some free memory.
            let freeMemoryPointer := mload(0x40)

            // Write the abi-encoded calldata into memory, beginning with the function selector.
            mstore(freeMemoryPointer, 0x23b872dd00000000000000000000000000000000000000000000000000000000)
            mstore(add(freeMemoryPointer, 4), and(from, 0xffffffffffffffffffffffffffffffffffffffff)) // Append and mask the "from" argument.
            mstore(add(freeMemoryPointer, 36), and(to, 0xffffffffffffffffffffffffffffffffffffffff)) // Append and mask the "to" argument.
            mstore(add(freeMemoryPointer, 68), amount) // Append the "amount" argument. Masking not required as it's a full 32 byte type.

            // We use 100 because the length of our calldata totals up like so: 4 + 32 * 3.
            // We use 0 and 32 to copy up to 32 bytes of return data into the scratch space.
            pop(call(gas(), _token, 0, freeMemoryPointer, 100, 0, 32))
        }
    }
}