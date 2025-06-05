const { createWalletClient, encodeFunctionData, http } = require('viem');
const { privateKeyToAccount } = require('viem/accounts');
const { config } = require('dotenv');

const { sepolia } = require('viem/chains');
sepolia.rpcUrls.default.http[0] = 'https://ethereum-sepolia-rpc.publicnode.com';
const { mainnet } = require('viem/chains');

// Set chain
const chain = sepolia;
//const chain = mainnet;

config();

const accountSender = privateKeyToAccount(process.env.PK_SENDER);
const accountDelegation = privateKeyToAccount(process.env.PK_DELEGATOR)
const contractToDelegate = 'TARGET_OF_DELEGATION';

const walletClientDelegation = createWalletClient({
  account: accountDelegation,
  chain,
  transport: http(),
});
const walletClientSender = createWalletClient({
  account: accountSender,
  chain,
  transport: http(),
});

async function main() {
  const authorization = await walletClientDelegation.signAuthorization({
    account: accountDelegation,
    contractAddress: contractToDelegate,
  });
  console.log(authorization);
  const hash = await walletClientSender.sendTransaction({
    authorizationList: [authorization],
    data: null, // You can use this to send call a function
    to: accountSender.address,
  });
  console.log(hash);
}

main();