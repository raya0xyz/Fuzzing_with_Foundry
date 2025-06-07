// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AllSafe {
   string public privateCompanyName = "SecretCompanyName";
   address private manager;

    constructor(){
    manager = msg.sender;
   }

   modifier onlyAdmin {
    require(msg.sender == manager, "Not the Manager");
    _;
}


   function changeName(string memory _newName) public onlyAdmin() {
    privateCompanyName = _newName;
   }
}