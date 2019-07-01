# Funds Distribution Token (FDT)

[![Build Status](https://travis-ci.org/atpar/funds-distribution-token.svg?branch=master)](https://travis-ci.org/atpar/funds-distribution-token)
[![npm version](http://img.shields.io/npm/v/funds-distribution-token.svg?style=flat)](https://npmjs.org/package/funds-distribution-token "View this project on npm")

**DRAFT IMPLEMENTATION. NOT AUDITED. DO NOT USE FOR TOKENS WITH REAL VALUE AT THIS TIME**

This repository contains a reference implementation of a token using the proposed Funds Distribution Standard, written in solidity.

*The Funds Distribution Standard is an extension to the ERC20 token standard that adds the functionality to represent claims on any type of crypto cash flow. It will be submitted as an Ethereum Improvement Proposal (EIP)*

## Features
- Scales to large numbers of transfers and large numbers of token holders
- An FDT contract can be instantiated to distribute funds either in Ether or in an Ethereum based token (e.g. ERC20, ERC777, etc.) 
- FD-Tokens can be minted or burned

## Usage
```
#TODO
```

## Architecture
- FDT base contract:
	- implements ERC20 standard interface
	- contains methods for calculating distributions according to the amount of FDTs a user owns
- FDT extension contracts:
	- contains methods for depositing and withdrawing funds in Ether or according to a token standard
	- provide compatibility for current and future token standards such as ERC20, ERC223, ERC777 and ERC1400

## EIP draft and further details

[The interface and the EIP's draft can be found here](EIP-DRAFT.md).

## Attribution
The idea for this implementation goes back to work originally done by [@Georgi87](https://github.com/Georgi87), [@ethers](https://github.com/ethers), [@miladmostavi](https://github.com/miladmostavi) and [@popra](https://github.com/popra) and was used in the [Tokit SingularDTVFund](https://github.com/Digital-Mob/singulardtv-tokitio-contracts) contracts. It was also inspired by [PoWH3D](https://etherscan.io/address/0xB3775fB83F7D12A36E0475aBdD1FCA35c091efBe#code). [Foundational work](https://medium.com/@weka/dividend-bearing-tokens-on-ethereum-42d01c710657) was done by [@arachnid](https://github.com/Arachnid) [and](https://github.com/bokkypoobah/DividendPayingTokenContract) [@BokkyPooBah](https://github.com/bokkypoobah).
