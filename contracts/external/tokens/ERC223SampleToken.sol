pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract ERC223ReceivingContract { 
  function tokenFallback(address _from, uint _value, bytes memory _data) public;
}

contract ERC223SampleToken is ERC20 {

	uint8 public constant DECIMALS = 18;
	uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(DECIMALS));

	
	constructor () public {
		_mint(msg.sender, INITIAL_SUPPLY);
	}

	function transfer(address _to, uint256 _value, bytes memory _data) 
		public 
		returns(bool)
	{
		uint codeLength;

		assembly { codeLength := extcodesize(_to) }

		require(super.transfer(_to, _value), "TRANFER_FAILED");
		
		if(codeLength > 0) {
			ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
			receiver.tokenFallback(msg.sender, _value, _data);
		}

		return true;
	}
	
	function transfer(address _to, uint256 _value) 
		public 
		returns(bool)
	{
		uint codeLength;
		bytes memory empty;

		assembly { codeLength := extcodesize(_to) }

		require(super.transfer(_to, _value), "TRANFER_FAILED");

		if(codeLength > 0) {
			ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
			receiver.tokenFallback(msg.sender, _value, empty);
		}

		return true;
	}
}