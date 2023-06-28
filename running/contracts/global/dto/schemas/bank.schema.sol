// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


library BankSchema {
    // =======================================
    // Schemas for Bank Module 
    // =======================================
    struct BankStorage {
        mapping(address => uint256) balances;
        bool paused;
    }
}