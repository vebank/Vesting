```
$$\    $$\ $$$$$$$$\ $$$$$$$\   $$$$$$\  $$\   $$\ $$\   $$\ 
$$ |   $$ |$$  _____|$$  __$$\ $$  __$$\ $$$\  $$ |$$ | $$  |
$$ |   $$ |$$ |      $$ |  $$ |$$ /  $$ |$$$$\ $$ |$$ |$$  / 
\$$\  $$  |$$$$$\    $$$$$$$\ |$$$$$$$$ |$$ $$\$$ |$$$$$  /  
 \$$\$$  / $$  __|   $$  __$$\ $$  __$$ |$$ \$$$$ |$$  $$<   
  \$$$  /  $$ |      $$ |  $$ |$$ |  $$ |$$ |\$$$ |$$ |\$$\  
   \$  /   $$$$$$$$\ $$$$$$$  |$$ |  $$ |$$ | \$$ |$$ | \$$\ 
    \_/    \________|\_______/ \__|  \__|\__|  \__|\__|  \__|
```
A. Description:
====
- This contract allows vesting tokens for private, public, core team, reserve, liquidity, marketing, airdrop.
- Tokens will be minted then lock up into Vesting smart contracts.
- The monthly unvesting is unleaseed at the end of each month (30 days), so that the Cliff is substracted by 1 month.
- Vesting schedule and wallet base on tokenomics at 25/08/2022.

B. Run
- VBVestingFactory is the main and is the only contract should be deployed.
- Remember to config the Token address and approriate startAtTimeStamp.
- Use TokenVesting.addBeneficiary to add total amout for each beneficiary/wallet.
- Use TokenVesting.claimVestedToken to claim the available tokens at a time.
