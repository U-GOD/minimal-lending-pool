# Minimal Lending Pool

A simple smart contract system to simulate lending and borrowing a single ERC-20 token. Inspired by basic DeFi lending markets such as Aave and Compound, but stripped down for learning purposes.

## 🪙 Overview

This project lets users:

- **Deposit** tokens into a shared pool.
- **Borrow** tokens against their deposits (up to 50% LTV).
- **Repay** borrowed tokens.
- **Withdraw** supplied tokens when not locked as collateral.

All balances and borrow limits are tracked per user.

## 📂 Contracts

### 🟢 LendToken.sol
- A mintable ERC-20 token for testing.
- Owner can mint arbitrary amounts.
- Deployed separately.

### 🟢 LendingPool.sol
- Core lending contract.
- Manages deposits, borrows, repayments, and withdrawals.
- Enforces collateralization (50% max borrow).

## 🛠️ Deployment

**1️⃣ Deploy LendToken**

Constructor parameter: `initialSupply`  
Example: `1000000000000000000000000` (1 million tokens)

**2️⃣ Deploy LendingPool**

Constructor parameter: `LendToken` contract address

## ⚙️ Setup and Testing

✅ **Mint tokens to your wallet**
```
LendToken.mint(yourAddress, amount)
```

✅ **Approve LendingPool to spend your tokens**
```
LendToken.approve(LendingPool.address, amount)
```

✅ **Deposit tokens**
```
LendingPool.deposit(amount)
```

✅ **Borrow tokens**

You can borrow up to 50% of your deposit:
```
LendingPool.borrow(amount)
```

✅ **Repay tokens**
```
LendingPool.repay(amount)
```

✅ **Withdraw tokens**
```
LendingPool.withdraw(amount)
```

## ✨ Example Deployed Contracts (zkSync Sepolia)

- **LendToken:** `0x70157E026a8C4Fa45f8c28a5be6D2874C864B027`
- **LendingPool:** `0x2882e9BED971c1C0CFef6F2C3D8b5D9F0419b06C`

## 💡 Learning Objectives

- Understand ERC-20 approvals and transfers  
- Learn collateralized lending logic  
- Explore borrow limits and repayments  
- Build confidence with Solidity patterns

## 📎 Resources

- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [Solidity Documentation](https://docs.soliditylang.org/)
- [Aave Protocol](https://aave.com)

## 🪙 License

MIT License
