const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

describe("Marketplace", function () {

 let Marketplace, marketplace, owner, addr1, addr2,register, name, storeName, sellerID, sellerAddress;
    //This will be run before each test
    beforeEach(async () => {
        // ethers.getContractFactory is not available in ordinary ethers library only available in hardhat 
        Marketplace = await ethers.getContractFactory('Marketplace');
        //Deploy the token
        marketplace = await Marketplace.deploy();

        //get signer object from the 20 account spinned in localhost
        [owner, addr1, addr2] = await ethers.getSigners();

    });

     //This is another test block
    describe('Deployment', () => {
        it('Should set the right owner', async () => {
            expect(await marketplace.owner()).to.equal(owner.address)
            console.log(owner.address);
        });

       
    });

    describe('Seller', () => {
        let register, name, storeName, sellerID, sellerAddress,sellerResponse;

        it('should register new seller', async () => {
            register = await marketplace.connect(addr1).registerSeller("John", "Jonnie Store");
            [name, storeName, sellerID, sellerAddress] = (await register.wait()).events[0].args[0];

            expect((name, storeName, sellerID, sellerAddress)).to.equal(("John", "Jonnie Store", 1, "0x70997970C51812dc3A010C7d01b50e0d17dc79C8"));

            console.log("Seller address" ,sellerAddress);

        });

       
    
        it('should return details of seller', async () => {

            sellerResponse = await marketplace.getSeller(addr1.address);
            console.log("seller response", await sellerResponse);
           
            expect((name, storeName, sellerID, sellerAddress)).to.equal(("John", "Jonnie Store", 1, "0x70997970C51812dc3A010C7d01b50e0d17dc79C8"));
            console.log(sellerResponse);

            // expect(await marketplace.getSeller(addr2.address)).to.revertedWith("Not a seller");
        });

        
    });

    

    describe('Product', () => {
        let product;

        it('should add product', async () => {
            product = await marketplace.connect(addr1).addProduct("Apple", "this is an apple", 100);

            console.log(product);
        });

        
    });
    
  
});