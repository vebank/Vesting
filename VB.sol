// SPDX-License-Identifier: MIT
// Power by: VeBank

pragma solidity ^0.8.0;

import './VIP180.sol';

/** Official VeBank token (VB) smart-contract */

contract VB is VIP180 {
    constructor() VIP180("VeBank Token", "VB") {
        // Mint and/then transfer to Vesting wallets.
        _mint(msg.sender, 1000 * 10 ** 6 * (10 ** 18));
    }
}