pragma solidity ^0.5.2;

import "../IFundsDistributionToken.sol";
import "../FundsDistributionToken.sol";


contract FDT_ERC223Extension is IFundsDistributionToken, FundsDistributionToken {

	// token that ClaimsToken takes in custodianship 
	IERC20 public fundsToken;

	modifier onlyFundsToken () {
		require(msg.sender == address(fundsToken), "FDT_ERC223Extension.onlyFundsToken: UNAUTHORIZED_SENDER");
		_;
	}

	constructor(
		address initialShareholder,
		string memory name, 
		string memory symbol,
		uint256 initialSupply,
		IERC20 _fundsToken
	) 
		public 
		FundsDistributionToken(initialShareholder, name, symbol, initialSupply)
	{
		require(address(_fundsToken) != address(0), "FDT_ERC223Extension: INVALID_FUNDS_TOKEN_ADDRESS");

		fundsToken = _fundsToken;
	}

	/**
	 * @dev Withdraws available funds for user.
	 */
	function withdrawFunds() 
		external
	{
		uint256 withdrawableFunds = _prepareWithdraw();
		
		require(fundsToken.transfer(msg.sender, withdrawableFunds), "FDT_ERC223Extension.withdrawFunds: TRANSFER_FAILED");
	}

	/**
	 * @dev For ERC223.
	 * Calls _registerFunds(), whereby magnifiedFundsPerShare gets updated.
	 * @param sender Sender of tokens
	 * @param value Amount of tokens
	 */
	function tokenFallback(address sender, uint256 value, bytes memory) 
		public 
		onlyFundsToken()
	{
		if (value > 0) {
			_distributeFunds(value);
			emit FundsDistributed(sender, value);
		}
	}
}