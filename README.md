# Funds Distribution Token

**DRAFT IMPLEMENTATION. NOT AUDITED. DO NOT USE FOR TOKENS WITH REAL VALUE AT THIS TIME**

A token that can represent claims on any type of crypto cash flow. Anyone can deposit funds, token holders can withdraw their share. This is a reference implementation of #xxx.

This contract can be used for distributing cash flows of tokenized assets such as dividends, loan repayments, fee or revenue shares among large numbers of token holders.

Based on [EIP1726](https://github.com/ethereum/EIPs/issues/1726) and [EIP1843](https://github.com/ethereum/EIPs/issues/1843).
The accounting logic is based on the implementation of @roger-wu and foundational work of @arachnid.

## Features
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

## Interface
```solidity
interface FundsDistributionToken {

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
