import { defineConfig } from "hardhat/config";
import hardhatEthers from "@nomicfoundation/hardhat-ethers";
import "dotenv/config";

const accounts = process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [];

export default defineConfig({
  plugins: [hardhatEthers],
  solidity: {
    version: "0.8.26",
    settings: { optimizer: { enabled: true, runs: 200 }, evmVersion: "paris" }
  },
  networks: {
    testnet: {
      type: "http",
      chainType: "l1",
      url: process.env.RPC_URL || "http://127.0.0.1:8545",
      chainId: Number(process.env.CHAIN_ID || 11155111),
      accounts
    }
  }
});
