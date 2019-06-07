# FundsDistributionToken

**DRAFT IMPLEMENTATION. NOT AUDITED. DO NOT USE FOR TOKENS WITH REAL VALUE AT THIS TIME**

A token that can represent claims on any type of crypto cash flow.

Usage examples are cash flows of assets such as dividends, loan repayments, fee or revenue shares among large numbers of token holders.
Anyone can deposit funds, token holders can withdraw their share.

Based on [EIP1726](https://github.com/ethereum/EIPs/issues/1726) and [EIP1843](https://github.com/ethereum/EIPs/issues/1843).
The accounting logic is based on the implementation of @roger-wu and foundational work of @arachnid.

## Main Features
- Scales to large numbers of transfers and large numbers of token holders
- An FDT contract can be instantiated to distribute funds either in Ether or in an Ethereum based token (e.g. ERC20, ERC777, etc.) 
- FD-Tokens can be minted or burned (enables ERC1400 compatiblity)

## Architecture
- FundsDistributionToken base contract:
	- implements ERC20 standard interface
	- contains methods for calculating distributions according to the amount of FDTs a user owns
- FundsDistributionToken extension contracts:
	- contains methods for depositing and withdrawing funds in Ether or according to a token standard
	- provide compatibility for current and future token standards such as ERC20, ERC223, ERC777 and ERC1400

