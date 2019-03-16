pragma solidity 0.5.0;

contract Ownable {
    address public owner;

    function Ownab1e() public {
        owner = msg.sender;
    }

    function kill() public {
        require(msg.sender == owner);

        selfdestruct(msg.sender);
    }
}
