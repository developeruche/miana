// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface BankController {
    function deposit() 
        external
        payable;

    function withdraw()
        external;

    function balance(
        address _addr
    )
        external 
        view
        returns (
            uint256 bal_
        );
}