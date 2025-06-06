# Pectra Educational CTFs

After researching the new Ethereum Pectra update, more specifically the EIP-7702 I decided to make some educational challenges and tell a little about the problems I encountered.

For now and after great effort I managed to deploy the first CTF but I plan to build at least two more.

These CTFs are deployed on mainnet and each one has the objective to “steal” a fabulous!!! and unique!!!! Buttpluggy 

For more information see [Buttpluggy](https://buttpluggy.com/mine) and the [WebtrES](https://discord.gg/f7BDj5Wy) community.

The idea in this is that after the challenge is solved(or after a week...) I will reveal the solution and explain a little bit how I did it and why.

And finally I am putting together a library with some utils functions although these may not be very useful...

If you want to donate for coffee and gas: `0x33753AE385d89b220c42745F9Fc7a8457475d36A`

## Send Delegation Transaction

> WARNING!!!! Use this script very careful, if you delegate to a vulnerable contract you can lose all your funds

- `cd EIP-7702Sender`
- `npm i`
- `echo "PK_SENDER=\nPK_DELEGATOR="  > .env`
- Fill `TARGET_OF_DELEGATION` of `main.js`
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

### First Challenge: 

<div>
    <span style="font-weight: bold;">AWARD:</span> Sergeant Serpent
    <div style="margin-top: -35px; margin-left: 175px;">  
        <img src="https://storage.googleapis.com/nftimagebucket/tokens/0x0000420538cd5abfbc7db219b6a1d125f5892ab0/preview/TVRjME5qVTJNRFU0Tnc9PV8xODU=.gif" alt="Sergeant Serpent" width="50">  
    </div>  
</div>

- Target: [`0x6Ee7BAEc10B60b2940c0631eFb3eeFB4C49c216d`](https://etherscan.io/address/0x6Ee7BAEc10B60b2940c0631eFb3eeFB4C49c216d#nfttransfers)
- Vault Contract: [Vault.sol](src/Vault.sol)
- Local Test: `forge test --match-contract VaultTest -vvv`
- Winner: [`0x8ADf...cD78`](https://etherscan.io/address/0x8ADf0B5a3A3a662c610028760A4D4e475651cD78#nfttransfers) on TX: [`0x752f...292c`](https://etherscan.io/tx/0x752fd6d8a04c7354d5c31ee7b1d56b512f5c1bf0bc99e2782a1b6ace4c88292c)



<div>
    <span style="font-weight: bold;">AWARD:</span> Sergeant PixelForge
    <div style="margin-top: -35px; margin-left: 175px;">  
        <img src="https://storage.googleapis.com/nftimagebucket/tokens/0x0000420538cd5abfbc7db219b6a1d125f5892ab0/preview/TVRjME9URTNNRGszTWc9PV80NDg=.gif" alt="Sergeant PixelForge" width="50">  
    </div>  
</div>

- Target: [`0xb45be2759a1BfcE416631F68f1c09E765Af1E851`](https://etherscan.io/address/0xb45be2759a1BfcE416631F68f1c09E765Af1E851)
- Winner: [`0x88d5...03F48`](https://etherscan.io/address/0x88d55F262E3320bdBDdBb8c692FEb7269B403F48)
- Delegation TX: [`0x1ffe...`](https://etherscan.io/tx/0x1ffe9e3419c8dac5e80fec1393a7ae5fa3c51d94612f474dca55fcf86bd42bbf#authorizationlist)
- Hack TX: [`0x9ec5...`](https://etherscan.io/tx/0x9ec5389474cb51f127e6f995bdf45fbb21c15be07d70b07a6d3a782413f2354f)