pragma solidity ^0.5.2;

import "../IFundsDistributionToken.sol";
import "../FundsDistributionToken.sol";


contract FDT_ETHExtension is IFundsDistributionToken, FundsDistributionToken {

	constructor(
		string memory name, 
		string memory symbol
	)
		public
		FundsDistributionToken(name, symbol) 
	{}

	/**
	 * @notice Withdraws available funds for user.
	 */
	function withdrawFunds() 
		external
	{
		uint256 withdrawableFunds = _prepareWithdraw();
		
		msg.sender.transfer(withdrawableFunds);
	}

	/**
	 * @notice The default function calls _distributeFunds() whereby magnifiedFundsPerShare gets updated.
	 */
	function () 
		external 
		payable 
	{
		if (msg.value > 0) {
			_distributeFunds(msg.value);
			emit FundsDistributed(msg.sender, msg.value);
		}
	}
}