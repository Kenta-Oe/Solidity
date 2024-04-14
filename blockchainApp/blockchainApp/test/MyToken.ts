import { expect } from "chai";
import { ethers } from "hardhat";

describe("MyToken contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();

    const myToken = await ethers.deployContract("myToken");

    const ownerBalance = await myToken.balanceOf(owner.address);

    expect(await myToken.totalSupply()).to.equal(ownerBalance);
  });
});