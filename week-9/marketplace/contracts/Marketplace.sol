//SPDX-License-Identifier: MIT
// Write a contract that does some very important work. It should contain some very important data structures like Structs,mappings,public and private variables,arrays etc[remember to be flexible s pick your choice]...Write a script using hardhat-ethersjs to deploy the contract and call the functions while logging the output to the console....Write a test in js to test some of its functionalities *

pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract Marketplace{
    address public owner;
    struct Seller{
        string name;
        string storeName;
        uint sellerID;
        address sellerAddress;
        bool isSeller;
    }

    struct Product{
        string name;
        string description;
        uint price;
        address sellerAddess;
        
    }

    mapping (address=>Seller) public SellerDetails;
    mapping (address=>uint) public SellerBalance;
    mapping (uint=> Product) public ProductDetails;
    uint sellerID = 1;
    uint productID = 1;

    event AddedProduct(Product product_);
    event RegisterSeller(Seller seller_);
    event UpdateProduct(Product product_);
    constructor(){
        owner = msg.sender;
    }
   

    function registerSeller(string memory _name, string memory _storeName) public returns(Seller memory) {
        Seller storage seller = SellerDetails[msg.sender];
        seller.name = _name;
        seller.storeName = _storeName;
        seller.sellerAddress = msg.sender;
        seller.isSeller = true;
        sellerID++;

        emit RegisterSeller(seller);
        return seller;
    }

    function getSeller(address account) public view returns(Seller memory){
        // require(isSeller[account] == true , "Not a seller");
        return SellerDetails[account];
    }

    function getSellerBalance() public view returns(uint){
        // require(owner == msg.sender, "")
        return SellerBalance[msg.sender];
    }

    function addProduct(string memory _name, string memory _description, uint _price ) public returns(Product memory){
        Seller memory seller = SellerDetails[msg.sender];
        require(seller.isSeller == true, "You cannot add product");
        Product storage product = ProductDetails[productID];

        product.name = _name;
        product.description = _description;
        product.price = _price;
        product.sellerAddess = msg.sender;
        productID++;
        emit AddedProduct(product);

        return product;

    }

    function updateProduct(uint _productID, string memory _name, string memory _description, uint _price ) public {
        require(_productID <= productID);
        Product storage product = ProductDetails[_productID];

        product.name = _name;
        product.description = _description;
        product.price = _price;

        emit UpdateProduct(product);

    }

    function viewProduct (uint _productID) public view returns(Product memory){
        return ProductDetails[_productID];
    }

    


}
