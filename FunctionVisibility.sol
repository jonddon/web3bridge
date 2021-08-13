//SPDX-License-Identifier: MIT
//Author: JOhn Odey

pragma solidity ^0.8.0;

contract FunctionVisibility{
    // Your contract is supposed to contain a very CRUCIAL function . 
    // Your first function accepts 3 different addresses and performs the keccak256 hash of the first 2.
    // it then hashes the result with the third address and returns the final hash...
    // The second CRUCIAL function gets the final hash from the first function above and accepts two arguments(a number and a bytes32 value).
    // it hashes the number separately, performs a typecasting(on the bytes32[second argument]) so as to convert it to a number,
    // hashes the number too, then hashes both of the resulting hashes with the hash gotten from the previous function
    // and finally returns the final hash
    
    function first(address addr1, address addr2, address addr3) private pure returns(bytes32 lastHash){
        bytes32 hash1 = keccak256(abi.encodePacked(addr1, addr2));
        lastHash = keccak256(abi.encodePacked(hash1, addr3));
    }
    
    function second(uint number, bytes32 value) public pure returns(bytes32 finalHash) {
        bytes32 firstHash = first(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
        bytes32 numberHash = keccak256(abi.encodePacked(number));
        bytes32 valueHash = keccak256(abi.encodePacked(uint256(value))); 
        
        finalHash = keccak256(abi.encodePacked(numberHash,valueHash, firstHash));
       
    }
}
