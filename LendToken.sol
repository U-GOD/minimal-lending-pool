// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import ERC20 and Ownable from OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title LendToken
/// @notice Mintable ERC-20 token for testing the lending pool
contract LendToken is ERC20, Ownable {
    // @notice Constructor sets the name, symbol, and initial supply
    constructor(uint256 initialSupply) ERC20("LendToken", "LEND") Ownable(msg.sender) {
        // Mint initial supply to deployer
        _mint(msg.sender, initialSupply);
    }

    /// @notice Allows the owner to mint tokens to any address
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}