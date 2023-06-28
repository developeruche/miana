// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BankSchema as Schema} from "../../../global/dto/schemas/bank.schema.sol";
import {Positions} from "../../../global/dto/positions.sol";
import {BankErrors as Errors} from "../../../global/errors/bank.error.sol";
import { AcessControl } from "../../access-control-module/providers/access-control.provider.sol";
import {AccessControlSchema} from "../../../global/dto/schemas/access-control.schema.sol";


library BankProvider {
    // =========================
    // EVENTS
    // =========================
    event Deposited(address owner, uint256 amount);
    event Withdrawal(address owner, uint256 amount);
    event Pause(bool status);


    modifier terminateIfPaused() {
        if(bankStorage().paused) {
            revert Errors.PAUSED_OPERATION_NOT_ALLOWED();
        }
        _;
    }

    function bankStorage() 
        internal 
        pure 
        returns (
            Schema.BankStorage storage ms
        ) 
    {
        bytes32 position = Positions.BANK_STORAGE_POSITION;
        assembly {
        ms.slot := position
        }
    }


    function deposit()
        internal 
        terminateIfPaused
    {
        Schema.BankStorage storage ss = bankStorage();
        ss.balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    function withdraw()
        internal
        terminateIfPaused
    {
        Schema.BankStorage storage ss = bankStorage();

        uint256 bal = ss.balances[msg.sender];

        ss.balances[msg.sender] = 0;

        (bool sent, ) = payable(msg.sender).call{value: bal}("");

        emit Deposited(msg.sender, msg.value);
    }


    function pause(
        bool _status
    )
        internal
    {
        AcessControl.hasRoleWithRevert(AccessControlSchema.Roles.BANK_MODULE_MANAGER, msg.sender);
        Schema.BankStorage storage ss = bankStorage();

        ss.paused = _status;

        emit Pause(_status);
    }

    function bal(address _addr)
        internal 
        view
        returns (
            uint256 bal_
        )
    {
        bal_ = bankStorage().balances[_addr];
    }

}