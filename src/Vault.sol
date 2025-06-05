// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Vault {
    mapping(address => bool) public approveAdmins;
    mapping(address => uint256) public balances;
    address public token;
    address public admin;

    function deposit(uint256 amount) external payable {
        (bool s,) = token.call(abi.encodeWithSignature(
            "transferFrom(address,address.uint256)", msg.sender, address(this), amount)
        );
        require(s);

        balances[msg.sender] = amount;
    }

    function withdraw(address to) external payable {
        token.call(abi.encodeWithSignature(
            "transferFrom(address,address,uint256)", address(this), msg.sender, balances[to])
        );

        balances[to] = 0;
    }

    function setToken(address _token) external payable {
        if (admin != address(0)) {
            require(msg.sender == admin, "Not admin");
        } else {
            require(approveAdmins[msg.sender] == true, "Not approve admin");
        }

        token = _token;
    }
}