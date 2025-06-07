// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {HandlerStatefulFuzzCatches} from "../src/HandlerStatefulFuzzCatches.sol";
import {HandlerWrapper} from "./Handler.t.sol";
import {YeildERC20} from "./mocks/YeildERC20.sol";
import {MockWETH} from "./mocks/MockWETH.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FuzzerContract is Test {

    HandlerStatefulFuzzCatches public handlerStatefulFuzzCatches;
    YeildERC20 public yeildERC20;
    MockWETH public mockWETH;
    HandlerWrapper public handler;

    uint256 public initialSupply;
    IERC20[] public listOfEIP20Tokens;

    address owner = makeAddr('I_m_psudo_usr');

    function setUp() public {
        vm.startPrank(owner);
        // this ERC20 will automatically mint 1_000_000e18 to owner.
        yeildERC20 = new YeildERC20();
        // MockWETH contract dosen't have a constructor that will auto mit,
        // So I ll have to mit token manually.
        mockWETH = new MockWETH();  // <----- Deploying
        initialSupply = yeildERC20.INITIAL_SUPPLY();  
        mockWETH.mint(msg.sender, initialSupply);  // <----- Minting same amount as yeildERC20

        listOfEIP20Tokens.push(yeildERC20);
        listOfEIP20Tokens.push(mockWETH);

        handlerStatefulFuzzCatches = new HandlerStatefulFuzzCatches(listOfEIP20Tokens);
        handler = new HandlerWrapper(handlerStatefulFuzzCatches, yeildERC20, mockWETH);

        bytes4[] memory selectors = new bytes4[](4);
        selectors[0] = handler.depositYeildERC20.selector;
        selectors[1] = handler.depositMockWETH.selector;
        selectors[2] = handler.withdrawMockWETH.selector;
        selectors[3] = handler.withdrawYeildERC20.selector;

        targetSelector(FuzzSelector({
            addr: address(handler),
            selectors: selectors
        }));

        targetContract(address(handler));

        
    }

    function statefulFuzz_testInvariant() public {
        vm.startPrank(owner);
        handlerStatefulFuzzCatches.withdrawToken(mockWETH);
        handlerStatefulFuzzCatches.withdrawToken(yeildERC20);
        vm.stopPrank();

        assert(mockWETH.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
        assert(yeildERC20.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
        assert(mockWETH.balanceOf(owner) == initialSupply);
        assert(yeildERC20.balanceOf(owner) == initialSupply);
    }

}