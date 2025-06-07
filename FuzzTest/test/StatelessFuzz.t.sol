// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


import {StatelessFuzzCatches} from "../src/StatelessFuzzCatches.sol";
import {Test, console} from "forge-std/Test.sol";

contract StatelessFuzz is Test {
    StatelessFuzzCatches public statelessFuzz;

    function setUp() public{
        statelessFuzz = new StatelessFuzzCatches();
    }

    function testFuzzdoMath( uint128 randint) public {
      assert(statelessFuzz.doMath(randint) != 0);
    }
}