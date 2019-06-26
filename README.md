# Funds Distribution Token (FDT)

**DRAFT IMPLEMENTATION. NOT AUDITED. DO NOT USE FOR TOKENS WITH REAL VALUE AT THIS TIME**

*The Funds Distribution Token is an extension to Ethereum ERC20 tokens that adds the functionality to represent claims on any type of crypto cash flow. It will be submitted as an Ethereum Improvement Proposal (EIP)*

This repository contains a reference implementation of the proposed interface in solidity.

When an ERC20 token implements the FDT-Interface, anyone can deposit funds and token holders can withdraw their share. This mechanism can be used for efficiently distributing cash flows of tokenized assets such as dividends, loan repayments, fee or revenue shares to large numbers of token holders.

Based on [EIP1726](https://github.com/ethereum/EIPs/issues/1726) and [EIP1843](https://github.com/ethereum/EIPs/issues/1843).
The accounting logic is based on the implementation of @roger-wu and foundational work of @arachnid.

## Features
- Scales to large numbers of transfers and large numbers of token holders
- An FDT contract can be instantiated to distribute funds either in Ether or in an Ethereum based token (e.g. ERC20, ERC777, etc.) 
- FD-Tokens can be minted or burned (enables ERC1400 compatiblity)

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
The idea for the implementation of the claims token goes back to work originally done by [@Georgi87](https://github.com/Georgi87), [@ethers](https://github.com/ethers), [@miladmostavi](https://github.com/miladmostavi) and [@popra](https://github.com/popra) and was used in the [Tokit SingularDTVFund](https://github.com/Digital-Mob/singulardtv-tokitio-contracts) contracts. It was also inspired by [PoWH3D](https://etherscan.io/address/0xB3775fB83F7D12A36E0475aBdD1FCA35c091efBe#code). [Foundational work](https://medium.com/@weka/dividend-bearing-tokens-on-ethereum-42d01c710657) was done by [@arachnid](https://github.com/Arachnid) [and](https://github.com/bokkypoobah/DividendPayingTokenContract) [@BokkyPooBah](https://github.com/bokkypoobah).
