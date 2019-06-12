---

eip: ERC-xxxx  
title: Funds Distribution Standard  
author: Johannes Pfeffer ([@jo-tud](https://github.com/jo-tud)), Roger Wu ([]()), Johannes Escherich ([@jo-es](https://github.com/jo-es)), Tom Lam ([]())  
discussions-to: #xxxx  
status: Draft  
type: Standards Track  
category: ERC  
created: 2019-06-12 
requires: ERC-20 (#20)  
superseeds: ERC-1726 (#1726), ERC-1843 (#1843)
---

# Funds Distribution Standard EIP

## Simple Summary
A standard for a token that represents claims on future cash flow of an asset such as dividends, loan repayments, fee or revenue shares among large numbers of token holders. Anyone can deposit funds, token holders can withdraw their claims.

- Very simple interface
- ERC-20 backwards compatible
- Supports funds in Ether or in ERC223 compatible tokens
- Efficient handling of fractional ownership of cash-flow claims
- Correctly distributes cash flow honoring all token transfers
- Scales well to many token holders and frequent transfers

## Abstract
![The Claims Token](res/ClaimsToken.png)

This standard proposes an efficient solution for distributing recurring payments such as dividends, loan repayments, fee or revenue shares among large numbers of token holders. The token holders are seen as fractional owners of future cash flow. The payments can be in Ether or ERC20 tokens and are stored in the token's "fund". Holders of a claims token can transfer their tokens at any time and can still be sure that their past claims to the cash flow of the token will be honored. The interface provides methods to deposit funds to be distributed, to get information about available funds and to withdraw funds a token holder is entitled to.

This standard can handle funds in Ether or in ERC223 compatible tokens.

This standard is backwards compatible with ERC20 (#20) and can easily be extended to be compatible with ERC-1400 (#1411) security token standards.

## Motivation
In the DeFi and OpenFinance ecosystem assets such as debt positions, loans, derivatives and bonds are emerging. These assets incur future cash flows, e.g. repayments or dividends. Currently there is no standard for efficiently distributing claims on future cash flow of financial contracts among token holders. A clear and simple standard is needed to allow Dapps and exchanges to work with cash-flow producing tokens.

## Rationale
Sending cash flow to a large group of token holders whenever it is received is limited by gas consumption. Thus, a solution must be used in which token holders actively withdraw the cumulative funds that they have a claim on. A token holder must be able to withdraw funds she has a claim on at any time. It must also be possible to transfer tokens at any time and the already accrued claims must still be honored. This requires some background accounting to be done in the transfer functions. The claims token standard solves this elegantly.

Example: A bond is represented by 100 tokens. Alice owns all 100 of these tokens and Bob own zero. The bond yields 10 Ether. Alice has a claim on 100% of that cash flow because when the 10 Ether were received she owned all the tokens. She decides to not withdraw the tokens but wait until more has accumulated.

Now Alice sends 50 tokens to Bob. Shortly after the bond yield another 10 Ether. Now Alice has is entitled to 15 Ether and Bob to 5 Ether. The ownership history is honored and Alice doesn't need to withdraw before she transfers the tokens.

## Interface/Specification
```Solidity

interface IFundsDistributionToken {

	/**
	 * @dev Returns the total amount of funds a given address is able to withdraw currently.
	 * @param owner Address of FundsDistributionToken holder
	 * @return A uint256 representing the available funds for a given account
	 */
	function withdrawableFundsOf(address owner) external view returns (uint256);

	/**
	 * @dev Withdraws all available funds for a FundsDistributionToken holder.
	 */
	function withdrawFunds() external payable;

	/**
	 * @dev This event emits when new funds are distributed
	 * @param by the address of the sender who distributed funds
	 * @param fundsDistributed the amount of funds received for distribution
	 */
	event FundsDistributed(address indexed by, uint256 fundsDistributed);

	/**
	 * @dev This event emits when distributed funds are withdrawn by a token holder.
	 * @param by the address of the receiver of funds
	 * @param fundsWithdrawn the amount of funds that were withdrawn
	 */
	event FundsWithdrawn(address indexed by, uint256 fundsWithdrawn);
}
```
## Optional Interface
to be inserted

## Reference Implementation
TBD

## Backwards Compatibility
The standard is backwards compatible with ERC20 tokens.

## Copyright
Public domain via [CC0](https://creativecommons.org/publicdomain/zero/1.0/deed.en)

## Attribution
The idea for the implementation of the claims token goes back to work originally done by [@Georgi87](https://github.com/Georgi87), [@ethers](https://github.com/ethers), [@miladmostavi](https://github.com/miladmostavi) and [@popra](https://github.com/popra) and was used in the [Tokit SingularDTVFund](https://github.com/Digital-Mob/singulardtv-tokitio-contracts) contracts.
TODO: add @arachnid, bookypoobar, ...
