pragma solidity 0.5.6;

contract EtherBank {
  mapping (address => uint) public balances;
  using SafeMath for uint256;

  constructor() public payable{
      require(msg.value == 10 ether);
  }

  function deposit(address to) payable public {
    balances[to] = balances[to].add(msg.value);
  }

  function withdraw(uint amount) public {
    if (balances[msg.sender]>= amount) {
      balances[msg.sender] = balances[msg.sender].sub(amount);
      bool success = msg.sender.send(amount);
      require(success);
    }
  }

  function challengeSolved() public view returns(bool){
    if (address(this).balance < 1 ether){
        return true;
    }
    return false;
  }

  function() payable external  {
    balances[msg.sender] = balances[msg.sender].add(msg.value);
  }

  function getBalance(address addr) view public returns(uint){
    return balances[addr];
  }

  function getBankBalance() view public returns(uint){
    return address(this).balance;
  }
}

library SafeMath {
    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}
