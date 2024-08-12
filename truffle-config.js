module.exports = {
  networks: {
    development: {
      host: "127.0.0.1", // Ganache biasanya berjalan di localhost
      port: 7545, // Default port Ganache adalah 7545
      network_id: "*", // match any network id
    },
  },
  // Solc compiler version
  compilers: {
    solc: {
      version: "0.8.0", // Versi compiler Solidity yang digunakan
    },
  },
};
