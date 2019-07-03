---

eip: ERC-xxxx  
title: Funds Distribution Standard  
author: Johannes Pfeffer ([@jo-tud](https://github.com/jo-tud)), Roger Wu ([@Roger-Wu](https://github.com/Roger-Wu)), Johannes Escherich ([@jo-es](https://github.com/jo-es)), Tom Lam ([@erinata](https://github.com/erinata))  
discussions-to: #xxxx  
status: Draft  
type: Standards Track  
category: ERC  
created: 2019-06-12 
requires: ERC-20 (#20)  
superseeds: ERC-1726 (#1726), ERC-1843 (#1843)
---

# Funds Distribution Token Standard (FDT)

## Simple Summary
The FDT EIP is a specification for an extension to the ERC20 token interface. It adds functionality to the token that enables it to represent **claims on future cash flow of an asset** such as dividends, loan repayments, fee or revenue shares. The incoming funds can be distributed efficiently among large numbers of token holders. Anyone can deposit funds, token holders can withdraw their claims.

Some key properties of the standard:
- Very simple interface
- ERC-20 backwards compatible
- Supports funds in Ether or tokens

This EIP is based on and superseeds [EIP1726](#1726) and [EIP1843](#1843).

## Abstract

This EIP proposes a standard interface for distributing payments such as dividends, loan repayments, fee or revenue shares among token holders. The token holders are seen as fractional owners of future cash flow. The payments can be in Ether or tokens and are seen as the token's "fund". FDT holders can transfer their tokens at any time and can be sure that their past claims to the cash flow of the token will be honored. The interface provides methods to deposit funds, to get information about available funds and to withdraw funds.

FDT is backwards compatible with ERC20 (#20) and can easily be extended to be compatible with other standards such as ERC-777 (#777) or ERC-1400 (#1411) security token standards.

## Motivation & Rationale
In the DeFi and OpenFinance ecosystem assets such as debt positions, loans, derivatives and bonds are emerging. These assets incur future cash flows, e.g. repayments or dividends. Currently there is no standard for handling claims on future cash flow of tokenized assets. A clear and simple standard is needed to allow Ethereum apps (dApps), wallets and exchanges to interact with cash-flow producing tokens.

## Specification
The specification is identical to the interface. It consists of a compulsory and an optional part.

### Interface
The mandatory part of the interface.
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
	function withdrawFunds() external;

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
### Optional Interface
The optional part of the interface.
```Solidity
interface IFundsDistributionTokenOptional {

	/** 
	 * @notice Deposits funds to this contract.
	 * The deposited funds may be distributed to other accounts.
	 */
	function depositFunds() external payable;

	/** 
	 * @notice Returns the total amount of funds that have been deposited to this contract but not yet distributed.
	 */
	function undistributedFunds() external view returns(uint256);

	/** 
	 * @notice Returns the total amount of funds that have been distributed.
	 */
	function distributedFunds() external view returns(uint256);

	/** 
	 * @notice Distributes undistributed funds to accounts.
	 */
	function distributeFunds() external;

	/** 
	 * @notice Deposits and distributes funds to accounts.
	 * @param from The source of the funds.
	 */
	function depositAndDistributeFunds(address from) external payable;

	/**
	 * @dev This event MUST emit when funds are deposited to this contract.
	 * @param by the address of the sender of who deposited funds.
	 * @param fundsDeposited The amount of distributed funds.
	 */
	event FundsDeposited(address indexed by, uint256 fundsDeposited);
}
```

## Reference Implementation
There are many possible implementations for the FDT interface. 
A reference implementation by the creators of the EIP [can be found here](https://github.com/atpar/funds-distribution-token). It efficiently handles fractional ownership of cash-flow claims and scales well to many token holders and frequent transfers.

## Backwards Compatibility
The standard is backwards compatible with ERC20 tokens.

## Copyright
Public domain via [CC0](https://creativecommons.org/publicdomain/zero/1.0/deed.en)
