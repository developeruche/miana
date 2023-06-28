// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {AccessControlSchema as Schema} from "../../../global/dto/schemas/access-control.schema.sol";


interface AccessControlController {
    function setUp(address _superuser) external;
    function grantRole(Schema.Roles _role, address _assignee) external;
    function revokeRole(Schema.Roles _role, address _assignee) external;
    function hasRole(Schema.Roles _role, address _assignee) external view returns (bool isAdmin_);
    function transferSuper(address _superuser) external;
}