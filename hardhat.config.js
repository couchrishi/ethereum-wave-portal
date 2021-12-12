require('@nomiclabs/hardhat-waffle');

module.exports = {
  solidity: '0.8.0',
  networks: {
    rinkeby: {
      url: '<Your alechemy API Link here>',
      accounts: ['<Your Wallet Key>'],
    },
  },
};