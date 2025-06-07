// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {AllSafe} from "../src/con.sol";

contract AllSafeTest is Test {

    AllSafe public allSafe;
    string public name1 = "Madhara_Uchia";
    address public owner = makeAddr("Owner");
    address public attacker = makeAddr("attacker");

    function setUp() public {
        vm.startPrank(owner);
        allSafe = new AllSafe();
        vm.stopPrank();
    }

    function testOwner() public {
        vm.startPrank(owner);
        allSafe.changeName(name1);
        vm.stopPrank();
        assertEq(allSafe.privateCompanyName(), name1);
    }

    function testAttacker() public {
        vm.startPrank(attacker);
        vm.expectRevert("Not the Manager");
        allSafe.changeName(name1);
        vm.stopPrank();
        assertEq(allSafe.privateCompanyName(), "SecretCompanyName");
        
    }

}