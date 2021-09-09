// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const ethers = hre.ethers;

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Marketplace = await hre.ethers.getContractFactory("Marketplace");
  const [owner, addr1, addr2] = await ethers.getSigners();
  console.log(owner.address)
  const marketplace = await Marketplace.connect(owner).deploy();

  await marketplace.deployed();

  console.log("Marketplace deployed to:", await marketplace.address);

  const addSeller = await marketplace.connect(addr1).registerSeller("John", "Jonnie Store");

  console.log((await addSeller.wait()).events[0].args[0]);

  const getSeller = await marketplace.getSeller("0x70997970C51812dc3A010C7d01b50e0d17dc79C8");

  console.log(getSeller);

  const getSellerBalance = await marketplace.connect(addr1).getSellerBalance()

  console.log(getSellerBalance.toString());

  const addProduct = await marketplace.connect(addr1).addProduct("Apple", "this is an apple", 100);

  console.log((await addProduct.wait()).events[0].args[0]);

  const updateProduct = await marketplace.connect(addr1).updateProduct(1, "Mango", "this is a mango", 50);
  
  console.log((await updateProduct.wait()).events[0].args[0]);

  const viewProduct = await marketplace.viewProduct(1);

  console.log(viewProduct);

  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
