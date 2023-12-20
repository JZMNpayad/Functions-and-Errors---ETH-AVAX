# Functions-and-Errors---ETH-AVAX Error Handling

### `revert`, `require`, and `assert`

The GachaMachine Smart Contract utilizes different error-handling mechanisms to ensure the integrity of operations and protect against undesired states.

#### `require`

The `require` statement is used in the `onlyOwner` and `hasEnoughFunds` modifiers to check specific conditions before executing the associated functions. For example:

- **`onlyOwner:`** Ensures that only the contract owner can call certain functions.

    ```solidity
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    ```

- **`hasEnoughFunds:`** Ensures that players have sufficient funds to play the gacha.

    ```solidity
    modifier hasEnoughFunds() {
        if (playerBalances[msg.sender] < gachaCost) {
            revert("Insufficient funds to play the gacha");
        }
        _;
    }
    ```

#### `revert`

The `revert` statement is used in the `hasEnoughFunds` modifier to explicitly revert the transaction if a condition is not met. In this case, if a player doesn't have enough funds to play the gacha, the transaction is reverted.

#### `assert`

The `assert` statement is used in the `deposit` function to ensure that the deposit amount is greater than zero. This is a safety check to catch unexpected issues during execution.

```solidity
function deposit(uint256 amount) external payable {
    // Ensure that the deposit amount is greater than zero
    assert(amount > 0);

    playerBalances[msg.sender] += amount;
}
```

These error-handling mechanisms collectively contribute to the contract's robustness and help prevent unintended behaviors.

--- 

