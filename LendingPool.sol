// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import the ERC-20 interface
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Minimal Lending Pool
 * @notice Users can deposit and borrow a single ERC-20 token.
 */
contract LendingPool is Ownable {
    // The ERC-20 token used in this lending pool
    IERC20 public immutable token;

    // Mapping of user address to deposit balance
    mapping(address => uint256) public deposits;

    // Mapping of user address to borrowed amount
    mapping(address => uint256) public borrows;

    /**
     * @notice Constructor sets the ERC-20 token address
     * @param _token The token contract address
     */
    constructor(address _token) Ownable(msg.sender) {
        require(_token != address(0), "Invalid token address");
        token = IERC20(_token);
    }

    /**
     * @notice Deposit tokens into the lending pool
     * @param amount The amount of tokens to deposit
     */
    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");

        // Transfer tokens from the user to this contract
        bool received = token.transferFrom(msg.sender, address(this), amount);
        require(received, "Token transfer failed");

        // Update the user's deposit balance
        deposits[msg.sender] += amount;
    }

    /**
     * @notice Borrow tokens from the pool
     * @param amount The amount of tokens to borrow
     */
    function borrow(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        require(amount <= token.balanceOf(address(this)), "Not enough liquidity in pool");

        // Simple rule: user must have at least 50% collateral deposited
        uint256 maxBorrow = deposits[msg.sender] / 2;
        require(amount <= maxBorrow, "Borrow amount exceeds collateral limit");

        // Update the borrow balance
        borrows[msg.sender] += amount;

        // Transfer tokens to the user
        bool sent = token.transfer(msg.sender, amount);
        require(sent, "Token transfer failed");
    }

    /**
     * @notice Repay borrowed tokens
     * @param amount The amount of tokens to repay
     */
    function repay(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        require(borrows[msg.sender] >= amount, "Repay amount exceeds borrowed balance");

        // Update the borrow balance
        borrows[msg.sender] -= amount;

        // Transfer tokens from user to the contract
        bool received = token.transferFrom(msg.sender, address(this), amount);
        require(received, "Token transfer failed");
    }

    /**
     * @notice Withdraw supplied tokens
     * @param amount The amount to withdraw
     */
    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        require(deposits[msg.sender] >= amount, "Withdraw exceeds supplied balance");

        // Update the user's supplied balance
        deposits[msg.sender] -= amount;

        // Transfer tokens to the user
        bool sent = token.transfer(msg.sender, amount);
        require(sent, "Token transfer failed");
    }
}
