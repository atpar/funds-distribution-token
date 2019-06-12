pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";


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