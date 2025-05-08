// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Contract for Spiderion Token (SPDR)
// This contract is created with the same principles followed for Solana, ensuring transparency and security for users.
// Support links and project information for users:
// www.spiderion.com - Official project website
// www.aioneum.com - More details about the project
// www.spiderion.store - Spiderion product store
// www.spiderion.help - Help center for support
// www.spiderion.online - Online activities and events

contract SpiderionSPDR is ERC20 {

    // Total supply of the token (14 billion tokens as specified)
    uint256 public initialSupply = 14000000000 * (10 ** 9); // 14 billion tokens with 9 decimals.

    address public owner;
    bool public mintingRevoked = false;

    // Constructor to initialize the contract with the name and symbol of the token
    constructor() ERC20("Spiderion", "SPDR") {
        owner = msg.sender;
        _mint(owner, initialSupply);
    }

    // Optional: Overriding the decimals function to ensure it matches the expected 9 decimals
    function decimals() public view virtual override returns (uint8) {
        return 9; // Ensuring the token uses 9 decimals
    }

    // Function to revoke minting rights (to ensure supply remains fixed)
    function revokeMinting() public {
        require(msg.sender == owner, "Only the owner can revoke minting.");
        mintingRevoked = true;
    }

    // Function to check if minting is still allowed
    function canMint() public view returns (bool) {
        return !mintingRevoked;
    }

    // Function to transfer ownership in case it is needed in the future
    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only the owner can transfer ownership.");
        require(newOwner != address(0), "New owner cannot be the zero address.");
        owner = newOwner;
    }

}
