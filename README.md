# Smart Contracts

This repo contains a series of smart contracts that were developed with the aim of learning solidity.

:warning: **These contracts are not meant to use in production** :warning:

## Contracts in the repo

### 1. Pay monthly salaries
Set employees salaries and pay them a monthly salary in ethers.

### 2. Auction
Set an auction that anyone can participate for a certain period of time is defined. There is, obviously, an offchain part of the auction in which the winner receives its prize.

### 3. Savings in a moneybox
Keep ethers safe, assuring that they cannot be moved before a selectd period of time.

### 4. Ponzi game
Play a Ponzi game in which you'd expect another user to double your bet.

## Getting Started

### 1. Install truffle

```npm install -g truffle```

### 2. Clone Repo

`git clone https://github.com/andrebrener/smart_contracts.git`

### 3. Edit migrations file

- Open the file [2_deploy_contracts.js](https://github.com/andrebrener/smart_contracts/blob/master/migrations/2_deploy_contracts.js).
- Set the name of the file of the contract to be deployed in the first line like this:
```var MyContract = artifacts.require('[FILE_NAME]');```

### 3. Deploy contract

- Run ```truffle develop``` to open its console.
- Run ```truffle compile``` to compile the contracts.
- Run ```truffle migrate``` to run the migrations.

For more information on how to use truffle and deploy contracts please use this excellent [guide](https://blog.zeppelin.solutions/a-gentle-introduction-to-ethereum-programming-part-3-abdd9644d0c2) from the Zeppelin team.
