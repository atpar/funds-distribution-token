pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract ERC223ReceivingContract { 
  function tokenFallback(address _from, uint _value, bytes memory _data) public;
}

contract ERC20SampleToken is ERC20 {

	uint8 public constant DECIMALS = 18;
	uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(DECIMALS));

	
	constructor () public {
		_mint(msg.sender, INITIAL_SUPPLY);
	}
}