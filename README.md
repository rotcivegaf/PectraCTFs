# Pectra Educational CTFs

After researching the new Ethereum Pectra update, more specifically the EIP-7702 I decided to make some educational challenges and tell a little about the problems I encountered.

For now and after great effort I managed to deploy the first CTF but I plan to build at least two more.

These CTFs are deployed on mainnet and each one has the objective to “steal” a fabulous!!! and unique!!!! Buttpluggy 

For more information see [Buttpluggy](https://buttpluggy.com/mine) and the [WebtrES](https://discord.gg/f7BDj5Wy) community.

The idea in this is that after the challenge is solved(or after a week...) I will reveal the solution and explain a little bit how I did it and why.

And finally I am putting together a library with some utils functions although these may not be very useful...

If you want to donate for coffee and gas: `0x33753AE385d89b220c42745F9Fc7a8457475d36A`

## Send Delegation Transaction

- `cd EIP-7702Sender`
- `npm i`
- `echo "PK_SENDER=\nPK_DELEGATOR="  > .env`
- Fill the `.env` file with your pk's
- source `.env`
- `node main.js`

## Start challenges

- `git clone git@github.com:rotcivegaf/PectraCTFs.git`
- `cd PectraCTFs`
- `forge install`
- `forge test --match-contract <<TEST CONTRACT NAME>> -vvv`

> All CTFs are inside the test folder.

## Challenges

First Challenge: 
- Target: [`0x6Ee7BAEc10B60b2940c0631eFb3eeFB4C49c216d`](https://etherscan.io/address/0x6Ee7BAEc10B60b2940c0631eFb3eeFB4C49c216d#nfttransfers)
- Vault Contract: [Vault.sol](src/Vault.sol)
- Local Test: `forge test --match-contract VaultTest -vvv`