// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {ERC721} from "solmate/tokens/ERC721.sol";
import {Vault} from "../src/Vault.sol";

contract VaultTest is Test {
    address hacker = address(51651651);
    address user = 0x6Ee7BAEc10B60b2940c0631eFb3eeFB4C49c216d;
    address huffplug = 0x0000420538CD5AbfBC7Db219B6A1d125f5892Ab0;

    function setUp() public {
        vm.createSelectFork(
            "https://go.getblock.io/aefd01aa907c4805ba3c00a9e5b48c6b",
            22634702
        );
    }

    function test_() public {
        vm.startBroadcast(hacker);
        
        // DO SOMETHING HERE!!!
        
        assertEq(ERC721(huffplug).ownerOf(185), hacker);
    }
}