# Foundry Smart Contract Lottery

This is a decentralized lottery project built using Foundry. The smart contract allows users to participate in a fair and transparent lottery system deployed on the Sepolia testnet.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- A wallet with test ETH for Sepolia (e.g., MetaMask)

## Installation

Clone the repository and install dependencies:

```sh
git clone https://github.com/your-repo/foundry-smart-contract-lottery
cd foundry-smart-contract-lottery
make install
```

## Environment Variables

Create a `.env` file in the root directory and add the following environment variables:

```ini
SEPOLIA_RPC_URL="your_sepolia_rpc_url"
PRIVATE_KEY="your_wallet_private_key"
ETHERSCAN_API_KEY="your_etherscan_api_key"
```

**Note:** Keep your `PRIVATE_KEY` secure and do not expose it publicly.

## Building the Project

Compile the smart contracts:

```sh
make build
```

## Running Tests

Run the contract tests with:

```sh
make test
```

## Deployment to Sepolia Testnet

To deploy the contract to the Sepolia network, run:

```sh
make deploy-sepolia
```

This will use the `DeployRaffle.s.sol` script and verify the contract on Etherscan.

## Verifying the Contract

After deployment, you can verify the contract manually using:

```sh
forge verify-contract \
  <DEPLOYED_CONTRACT_ADDRESS> \
  src/Raffle.sol:Raffle \
  --rpc-url ${SEPOLIA_RPC_URL} \
  --etherscan-api-key ${ETHERSCAN_API_KEY} \
  --compiler-version 0.8.21
```

Replace `<DEPLOYED_CONTRACT_ADDRESS>` with the actual deployed contract address.

## License

This project is licensed under the MIT License.

