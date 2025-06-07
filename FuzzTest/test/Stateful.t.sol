// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {StatefulFuzzCatches} from "../src/StatefulFuzz.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract StatefulFuz is Test {

    StatefulFuzzCatches public statefulInstance;

    function setUp() public {
        statefulInstance = new StatefulFuzzCatches();
        targetContract(address(statefulInstance));
    }

    function statefulFuzz_statefulFuz() public {
        assert(statefulInstance.storedValue() != 0);
    }

}