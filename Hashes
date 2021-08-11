// SPDX-License-Identifier: GPL-3.0;
pragma solidity 0.8.1;

contract Hashes{
    
    
    function firsthash(uint a, uint b) public returns(bytes32){
       return keccak256(abi.encodePacked(a, b));
    }
    
    function secondhash(uint c, string memory d) public returns(bytes32){
       return keccak256(abi.encodePacked(c, d));
    }
    
    
    function Finalhash() public returns(bytes32, bytes32) {
        bytes32 firsthash_ = firsthash(5,6);
        
         bytes32 secondhash_ = secondhash(5,"Timidan");
         
         return(firsthash_, secondhash_);
    }
}
