// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
// A particular financial institution is looking to have their records stored onchain 
// and looking to have an *external *`identifier` tied to each customers Details....
// the identifier should be the keccak256 hash of the customer's name and time of registration , 
//each customer can also approve another customer to view their details
// [meaning that only admins and approved customers have the right to view another customer's data]....
// For simplicity purposes, the Bank is looking to have a separate contract that has all *setter* functions 
// and another contract that has all the *getter * 
// functions(Interacting with each other of course)..
// Finally, they want an interface for all the contracts they have......
//Notee: USE THE APPROPRIATE FUNCTION AND VARIABLE VISIBILITY SPECIFIERS
contract Bank{
    
    address public admin;
    constructor(){
        admin = msg.sender;
    }
    
    modifier onlyAdmin(){
        require(msg.sender == admin, "Only Admin can call this function");
        _;
    }
    struct Customer{
        string name;
        uint age;
        uint createdAt;
        address _address;
    }
    
    mapping(bytes32 => Customer) public customersDetails;
    mapping(bytes32 => mapping(address => bool)) public canCheckBalance;
    
    function register(string memory _name, uint _age) public returns(bytes32){
        bytes32 customerHash = bytes32(keccak256(abi.encodePacked(_name, block.timestamp)));
        Customer storage customer = customersDetails[customerHash];
        customer.name = _name;
        customer.age = _age;
        customer.createdAt = block.timestamp;
        customer._address = msg.sender;
        
        return customerHash;
    }
    
    function approveChecker(bytes32 _customerHash, address _checker) public{
        require(_checker != address(0), "Cannot allow address zero");
        Customer memory customer = customersDetails[_customerHash];
        require(customer._address == msg.sender, "You cannot approve the approve this address");
        canCheckBalance[_customerHash][_checker] = true;
    }
    
    function disapproveChecker(bytes32 _customerHash, address _checker) public{
        require(_checker != address(0), "Cannot allow address zero");
        Customer memory customer = customersDetails[_customerHash];
        require(customer._address == msg.sender, "You cannot approve the disapprove this address");
        canCheckBalance[_customerHash][_checker] = false;
    }
    
}
contract BankGetter {
    Bank bank;
    constructor(address bankAddress){
        bank = Bank(bankAddress);
    }
    
    
    function checkCustomerDetails(bytes32 _customerHash) public view returns(string memory,uint256,uint256,address){
        (,,, address a) = bank.customersDetails(_customerHash);
        require(bank.canCheckBalance(_customerHash,msg.sender) == true || a == msg.sender || bank.admin() == msg.sender, "You are not permitted to check this customer details");
        
        return bank.customersDetails(_customerHash);
    }
    
    
}