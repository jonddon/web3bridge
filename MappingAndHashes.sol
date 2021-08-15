// A contract contains two very important mappings which are used to track some very *private* info...
// The first mapping allows you to know how many times an address has called a function, 
// the second one allows you to know the function hash that the address called last...
// Write three different functions that don't *really do anything but returns a bool value* 
// and update the mappings accordingly

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract mappingsAssignment{
    mapping(address => uint) addressToInt;
    mapping(address => bytes32) addressToHash;
    
    function first() public returns(bool){
        addressToInt[msg.sender]++;
        addressToHash[msg.sender] = keccak256(abi.encodeWithSignature("first()"));
        return true;
    }
    
    
     function second() public returns(bool){
         addressToInt[msg.sender]++;
         addressToHash[msg.sender] = keccak256(abi.encodeWithSignature("second()"));
        return true;
    }
    
     function third() public returns(bool){
         addressToInt[msg.sender]++;
         addressToHash[msg.sender] = keccak256(abi.encodeWithSignature("third()"));
        return true;
    }
    
}
