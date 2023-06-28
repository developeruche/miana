// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {BankController as Controller} from "./controllers/bank.controller.sol";
import {BankProvider as provider} from "./providers/bank.provider.sol";

contract Bank is Controller{
    function deposit() 
        external
        payable 
    {
        provider.deposit();
    }

    function withdraw()
        external 
    {
        provider.withdraw();
    }

    function pause(
        bool _status
    )
        external 
    {
        provider.pause(_status);
    }

    function balance(
        address _addr
    )
        external 
        view
        returns (
            uint256 bal_
        )
    {
        bal_ = provider.bal(_addr);
    }


}