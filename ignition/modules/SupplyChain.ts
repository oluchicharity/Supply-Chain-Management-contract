import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { ethers } from "hardhat";

const SupplyChainModule = buildModule("SupplyChainModule", (m) => {
    const deploySupplyChain = m.contract("SupplyChain", []);

    return { deploySupplyChain};
});

export default SupplyChainModule;