pragma solidity ^0.5.2;

import "../external/math/SafeMathUint.sol";
import "../external/math/SafeMathInt.sol";

import "../IFundsDistributionToken.sol";
import "../FundsDistributionToken.sol";


contract FDT_ERC20Extension is IFundsDistributionToken, FundsDistributionToken {

	using SafeMathUint for uint256;
	using SafeMathInt for int256;

	// token in which the funds can be sent to the FundsDistributionToken
	IERC20 public fundsToken;
	
	// balance of fundsToken that the FundsDistributionToken currently holds
	uint256 public fundsTokenBalance;


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
	 * @notice Withdraws all available funds for a token holder
	 */
	function withdrawFunds() 
		external 
	{
		uint256 withdrawableFunds = _prepareWithdraw();
		
		require(fundsToken.transfer(msg.sender, withdrawableFunds), "TRANSFER_FAILED");

		_updateFundsTokenBalance();
	}

	/**
	 * @dev Updates the current funds token balance 
	 * and returns the difference of new and previous funds token balances
	 * @return A int256 representing the difference of the new and previous funds token balance
	 */
	function _updateFundsTokenBalance() internal returns (int256) {
		uint256 prevFundsTokenBalance = fundsTokenBalance;
		
		fundsTokenBalance = fundsToken.balanceOf(address(this));

		return int256(fundsTokenBalance).sub(int256(prevFundsTokenBalance));
	}

	/**
	 * @notice Register a payment of funds in tokens. May be called directly after a deposit is made.
	 * @dev Calls _updateFundsTokenBalance(), whereby the contract computes the delta of the previous and the new 
	 * funds token balance and increments the total received funds (cumulative) by delta by calling _registerFunds()
	 */
	function updateFundsReceived() external {
		int256 newFunds = _updateFundsTokenBalance();

		if (newFunds > 0) {
			_distributeFunds(newFunds.toUint256Safe());
		}
	}
}