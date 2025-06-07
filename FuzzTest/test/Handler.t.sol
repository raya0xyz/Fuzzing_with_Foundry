// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {HandlerStatefulFuzzCatches} from "../src/HandlerStatefulFuzzCatches.sol";
import {MockWETH} from "./mocks/MockWETH.sol";
import {YeildERC20} from "./mocks/YeildERC20.sol";


// This contract is nothing, it just 
// Launches main contract and dose sateless fuzzing with bounded _amount.
contract HandlerWrapper is Test {

    HandlerStatefulFuzzCatches public handlerStateful;
    MockWETH public mockWETH;
    YeildERC20 public yeildERC20;
    address public owner;

    constructor(
        HandlerStatefulFuzzCatches _handlerStateful,
        YeildERC20 _yeildERC20,
        MockWETH _mockWETH
        ){
            handlerStateful = _handlerStateful;
            mockWETH = _mockWETH;
            yeildERC20 = _yeildERC20;
            owner = yeildERC20.owner();
        }

    function depositYeildERC20(uint256 _amount) public {
        vm.startPrank(owner);
        uint256 amount = bound(_amount, 0, yeildERC20.balanceOf(owner));
        // Approve Contract to use Owner's Token
        yeildERC20.approve(address(handlerStateful),amount);
        handlerStateful.depositToken(yeildERC20,amount);
        vm.stopPrank();
    }


    function depositMockWETH(uint256 _amount) public {
        vm.startPrank(owner);
        uint256 amount = bound(_amount,0,mockWETH.balanceOf(owner));
        // Approve Contract to use Owner's Token
        mockWETH.approve(address(handlerStateful),amount);
        handlerStateful.depositToken(mockWETH,amount);
        vm.stopPrank();
    }

    function withdrawYeildERC20() public {
        vm.startPrank(owner);
        handlerStateful.withdrawToken(yeildERC20);
        vm.stopPrank();
    }

    function withdrawMockWETH() public {
        vm.startPrank(owner);
        handlerStateful.withdrawToken(mockWETH);
        vm.stopPrank();
    }

}




