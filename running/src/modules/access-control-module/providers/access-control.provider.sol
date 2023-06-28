// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AccessControlSchema as Schema} from "../../../global/dto/schemas/access-control.schema.sol";
import {Positions} from "../../../global/dto/positions.sol";
import {AccessControlError as Errors} from "../../../global/errors/access-control.error.sol";





library AcessControl {
    // ================================
    // EVENT
    // ================================
    event RoleGranted(Schema.Roles role, address assignee);
    event RoleRevoked(Schema.Roles role, address assignee);
    event Setuped(address superuser);
    event SuperuserTransfered(address new_superuser);


  function accessControlStorage() internal pure returns (Schema.AccessControlStorage storage ms) {
    bytes32 position = Positions.ACCESS_CONTROL_STORAGE_POSITION;
    assembly {
      ms.slot := position
    }
  }

  function enforceSuperUser(address _addr) internal view {
    Schema.AccessControlStorage storage ms = accessControlStorage();
    if(_addr != ms.superuser) {
        revert Errors.NOT_SUPERUSER();
    }
  }

  function setUp(address _superuser) internal {
    Schema.AccessControlStorage storage ms = accessControlStorage();
    if(ms.is_initialized == true) {
        revert Errors.HAS_BEEN_INITIALIZED();
    }

    ms.superuser = _superuser;
    ms.is_initialized = true;

    emit Setuped(_superuser);
  }


  function grantRole(address _assignee, Schema.Roles _role) internal {
    enforceSuperUser(msg.sender);
    Schema.AccessControlStorage storage ms = accessControlStorage();
    ms.role[_assignee] = _role;

    emit RoleGranted(_role, _assignee);
  }

  function revokeRole(Schema.Roles _role, address _assignee) internal {
    enforceSuperUser(msg.sender);
    Schema.AccessControlStorage storage ms = accessControlStorage();
    ms.role[_assignee] = Schema.Roles.DEFAULT;

    emit RoleRevoked(_role, _assignee);
  }

  function hasRole(Schema.Roles _role, address _assignee) internal view returns(bool has_role) {
    Schema.AccessControlStorage storage ms = accessControlStorage();
    has_role = _assignee == ms.superuser|| _role == ms.role[_assignee];
  }


  function hasRoleWithRevert(Schema.Roles _role, address _assignee) internal view returns(bool has_role) {
    if(hasRole(_role, _assignee)) {
        return true;
    } else {
        revert Errors.NOT_ROLE_MEMBER();
    }
  }


  function transferSuper(address _superuser, address _current_caller) internal {
    enforceSuperUser(_current_caller);
    Schema.AccessControlStorage storage ms = accessControlStorage();
    ms.superuser = _superuser;

    emit SuperuserTransfered(_superuser);
  }
}