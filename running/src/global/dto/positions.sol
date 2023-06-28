// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


library Positions {
    bytes32 constant BANK_STORAGE_POSITION = keccak256("diamond.standard.bank.storage");
    bytes32 constant ACCESS_CONTROL_STORAGE_POSITION = keccak256("diamond.standard.access.control.storage");
}