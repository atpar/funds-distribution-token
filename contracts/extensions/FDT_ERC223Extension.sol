pragma solidity ^0.5.2;

import "../IFundsDistributionToken.sol";
import "../FundsDistributionToken.sol";


contract FDT_ERC223Extension is IFundsDistributionToken, FundsDistributionToken {

	// token that ClaimsToken takes in custodianship 
	IERC20 public fundsToken;

	modifier onlyFundsToken () {
		require(msg.sender == address(fundsToken), "UNAUTHORIZED_SENDER");
		_;
	}

	constructor(IERC20 _fundsToken) 
		public 
		FundsDistributionToken()
	{
		require(address(_fundsToken) != address(0), "INVALID_FUNDS_TOKEN_ADDRESS");

		fundsToken = _fundsToken;
	}

	/**
	 * @dev Withdraws available funds for user.
	 */
	function withdrawFunds() 
		external 
		payable 
	{
		require(msg.value == 0, "ETHER_NOT_ACCEPTED");

		uint256 withdrawableFunds = _prepareWithdraw();
		
		require(fundsToken.transfer(msg.sender, withdrawableFunds), "TRANSFER_FAILED");
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