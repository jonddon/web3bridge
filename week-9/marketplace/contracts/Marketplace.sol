//SPDX-License-Identifier: MIT
// Write a contract that does some very important work. It should contain some very important data structures like Structs,mappings,public and private variables,arrays etc[remember to be flexible s pick your choice]...Write a script using hardhat-ethersjs to deploy the contract and call the functions while logging the output to the console....Write a test in js to test some of its functionalities *

pragma solidity ^0.8.0;

contract Marketplace{
    address public owner;
    struct Seller{
        string name;
        string storeName;
        uint sellerID;
        address sellerAddress;
    }

    struct Product{
        string name;
        string description;
        uint price;
        uint sellerID;
    }

    mapping (address=>Seller) public SellerDetails;
    mapping (address=>uint) public SellerBalance;
    mapping (address=>bool) public isSeller;
    mapping (uint=> Product) public ProductDetails;
    uint sellerID = 1;
    uint productID = 1;

    event AddedProduct(Product product_);
    event RegisterSeller(Seller seller_);
    event UpdateProduct(Product product_);
    constructor(){
        owner = msg.sender;
    }
    modifier onlySeller(){
        require(isSeller[msg.sender] == true, "Seller: Not a seller");
        _;
    }

    function registerSeller(string memory _name, string memory _storeName) public returns(bool) {
        Seller storage seller = SellerDetails[msg.sender];
        seller.name = _name;
        seller.storeName = _storeName;
        seller.sellerID = sellerID;
        seller.sellerAddress = msg.sender;
        isSeller[msg.sender] = true;
        sellerID++;

        emit RegisterSeller(seller);
        return true;
    }

    function getSeller(address account) public view returns(Seller memory){
        return SellerDetails[account];
    }

    function addProduct(string memory _name, string memory _description, uint _price ) public onlySeller {
        Product storage product = ProductDetails[productID];

        product.name = _name;
        product.description = _description;
        product.price = _price;
        productID++;
        emit AddedProduct(product);

    }

    function updateProduct(uint _productID, string memory _name, string memory _description, uint _price ) public onlySeller {
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
