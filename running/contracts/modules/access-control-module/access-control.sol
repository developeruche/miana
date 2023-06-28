// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import {AcessControl } from "./providers/access-control.provider.sol";
import {AccessControlSchema as Schema } from "../../global/dto/schemas/access-control.schema.sol";
import {AccessControlController as Controller } from "./controllers/access-control.controller.sol";

/// @notice this contract would be handling access control matter for the web3bridge doa ecosystem
contract AccessControl is Controller {
    /// @notice this function would be used for initilizing the superuser
    /// @dev this function can only called once
    /// @param _superuser: this is the address of the would be superuser
    function setUp(address _superuser) external override {
        AcessControl.setUp(_superuser);
    }

    /// @notice this function would be useed to grant role to an account 
    /// @dev [this is would be guided by this assess control] (and this access control has been implemented in the provider)
    /// @param _role: this is the role this is to be assigned to the address
    /// @param _assignee: this is the address the role would be assigned to
    function grantRole(Schema.Roles _role, address _assignee) external override  {
        AcessControl.grantRole(_assignee, _role);
    }

    /// @notice this function would be used by the superuser to revoke role given to and address
    /// @dev during this process, this function would be gated in that only yhe superuser can make this call
    function revokeRole(Schema.Roles _role, address _assignee) external override  {
        AcessControl.revokeRole(_role, _assignee);
    }

    /// @notice this function is a view that would be used to check if an address has a role
    /// @dev this function would not be guided
    /// @param _role: this is the role this is to be assigned to the address
    /// @param _assignee: this is the address the role would be assigned to
    function hasRole(Schema.Roles _role, address _assignee) external override  view returns (bool isAdmin_) {
        isAdmin_ = AcessControl.hasRole(_role, _assignee);
    }

    /// @notice this function would be used to transfer superuser ownership to different account
    /// @dev only superuser can make this change
    /// @param _superuser: this is the address of the would be superuser
    function transferSuper(address _superuser) external override  {
        AcessControl.transferSuper(_superuser, msg.sender);
    }
}