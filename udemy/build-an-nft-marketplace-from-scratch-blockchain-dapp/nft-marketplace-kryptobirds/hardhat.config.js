require("@nomiclabs/hardhat-waffle");
const projectId = 'be1e3e21ae194245a8cd36dc19df5a30'
const fs = require('fs')
const keyData = fs.readFileSync('./p-key.txt', {
  encoding:'utf8', flag:'r'
})

console.log('[keyData]', keyData)

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 module.exports = {
  defaultNetwork: 'hardhat',
  networks:{
    hardhat:{
      chainId: 1337 // config standard 
    },
    mumbai:{
      url:`https://polygon-mumbai.infura.io/v3/${projectId}`,
      accounts:[keyData]
    },
    mainnet: {
      url:`https://mainnet.infura.io/v3/${projectId}`,
      accounts:[keyData]
    }
  },
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
};
