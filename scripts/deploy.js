import hre from "hardhat";

async function main() {
  const { ethers } = await hre.network.create();
  const claimAmount = ethers.parseEther(process.env.CLAIM_AMOUNT_ETH || "0.001");
  const cooldown = Number(process.env.COOLDOWN_SECONDS || 86400);
  const Factory = await ethers.getContractFactory("TestnetFaucet");
  const faucet = await Factory.deploy(claimAmount, cooldown);
  await faucet.waitForDeployment();
  console.log("TestnetFaucet:", await faucet.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
