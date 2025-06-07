# Fuzzing_with_Foundry

This repository documents my learning journey with **Fuzzing in Solidity using Foundry**. While building smart contracts with Foundry, I explored how fuzz testing can uncover hidden bugs and vulnerabilities by feeding contracts with random and unexpected inputs.

## Overview

Fuzzing in Foundry offers deep insights into how smart contracts can fail under unpredictable conditions. By observing how `forge test` behaves during crashes or failures, developers can identify edge cases and strengthen their contracts.

In this project, I explored:

- **Stateless Fuzzing**  
  Simple fuzzing of functions without tracking state across calls.

- **Stateful (Invariant) Fuzzing**  
  Tests invariants across a sequence of operations to verify that certain properties always hold.

- **Fuzzing with Wrapper Contracts**  
  Uses handler contracts to restrict and guide fuzzing behavior, avoiding the problem of path explosion due to excessive randomness.

## Project Structure

### Contracts

- `StatelessFuzzCatches.sol`:  
  Demonstrates basic stateless fuzzing to identify crashes or assertion failures from random inputs.

- `StatefulFuzz.sol`:  
  Introduces invariants and the fundamentals of stateful fuzzing.

- `HandlerStatefulFuzzCatches.sol`:  
  Uses a handler contract to guide fuzzing behavior. A modifier ensures only supported token addresses are accepted. This file is more advanced and practical, simulating real-world testing scenarios.

### Mock Tokens

To simulate real-world token interactions, we use mock ERC20 tokens:

- `YieldERC20`
- `MockUSDC`
- `MockWETH`

During fuzzing with `YieldERC20`, we discovered that after a sequence of transactions, the contract required an unexpected token payment, violating our invariants. This behavior demonstrates how some tokens, like `YieldERC20`, have unusual characteristics that can break assumptions in smart contracts.

## Key Takeaways

- Random fuzzing without constraints can lead to **path explosion**, making it inefficient.
- Handler contracts and defined inputs help **focus fuzzing efforts**.
- Stateful fuzzing helps detect subtle contract behaviors that are not obvious in isolated function calls.
- Simulating real-world tokens is essential for uncovering bugs tied to specific token logic.

## Requirements

- [Foundry](https://book.getfoundry.sh/)
- Solidity ^0.8.*
- Install Lib
```
forge install foundry-rs/forge-std
forge install OpenZeppelin/openzeppelin-contracts
```

## Running the Tests

```bash
forge install
forge build
forge test
```
