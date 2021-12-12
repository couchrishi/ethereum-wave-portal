const main = async () => {
  const WaveContractFactory = await hre.ethers.getContractFactory("WavePortal");

  /* Deploy contract with initial funds of 0.1 Ether */
  const waveContract = await WaveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });

  await waveContract.deployed();
  console.log("Contract address:", waveContract.address);

  /* Check Balance */
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract Balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  /* Let's try multiple waves now and see who the lucky winner is*/
  let waveTxn = await waveContract.wave("This is wave 1");
  await waveTxn.wait();

  let waveTxn2 = await waveContract.wave("This is wave 2");
  await waveTxn2.wait();

  /* Get contract address from this contract to see what happened */
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract Balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  /* Test the getAllWaves function */
  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};
const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
