
import { expect } from "chai";
import hre from 'hardhat';
import { Shipping } from "../typechain-types";

describe("Shipping", function () {
    let shippingContract: Shipping;
    before(async () => {
        // ⽣成合约实例并且复⽤ 
        shippingContract = await hre.ethers.deployContract("Shipping", []);
        // assert that the value is correct 
        expect(await shippingContract.Status()).to.equal("Pending");
        // calling the Shipped() function
        await shippingContract.Shipped();
        // Checking if the status is Shipped
        expect(await shippingContract.Status()).to.equal("Shipped");
    });

    it("should return correct event description", async () => {
        if (shippingContract) {
            await expect(shippingContract.Delivered())
                .to.emit(shippingContract, "LogNewAlert") 
                .withArgs('Your package has arrived');
        }
    })
});