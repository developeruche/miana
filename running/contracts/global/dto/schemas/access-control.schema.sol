// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



library AccessControlSchema {
    enum Roles {
        // this is the default access class all user has this role
        DEFAULT,
        // this is the role of the staking manager
        BANK_MODULE_MANAGER
        
    }

    struct AccessControlStorage {
        mapping(address => Roles) role; // address => role
        address superuser; // The superuser can preform all the role and assign role to addresses
        bool is_initialized; // a flag to check if superuser has been assisgned 
    }
}