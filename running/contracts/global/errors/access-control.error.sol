// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



/// @notice this library holds all the errors related to the Access control module 
library AccessControlError {
  error NOT_SUPERUSER();
  error HAS_BEEN_INITIALIZED();
  error NOT_ROLE_MEMBER();
}
