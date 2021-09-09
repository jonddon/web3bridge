const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Marketplace", function () {

 let Marketplace, marketplace, owner, addr1, addr2;
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
        });

        // it('should assgin the total supply to the owner', async () => {
        //     const ownerBalance = await token.balanceOf(owner.address);
        //     expect(await token.totalSupply()).to.equal(ownerBalance);
        // });
    });

    describe('Register Seller', () => {
        it('should register new seller', async () => {
            expect(await marketplace.connect(addr1).registerSeller("John", "Jonnie Store")).to.equal(true);
        });
    })
    
  
});