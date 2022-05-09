pragma solidity ^0.4.23;

contract Inheritance{

    address owner;
    bool alive;
    uint property;

    constructor() public payable {
        owner = msg.sender;
        property = msg.value;
        alive = true;
    }

    modifier realOwner {
        require(msg.sender == owner);
        _;
    }

    modifier isAlive {
        require(alive == false);
        _;
    }

    address[] wallets;

    mapping (address => uint) inheritance;

    function setup(address _wallet, uint _inheritance) public realOwner {
        wallets.push(_wallet);
        inheritance[_wallet] = _inheritance;
    }

    function propertyTransfer() private isAlive{
        for(uint i=0;i<wallets.length;i++){
            wallets[i].transfer(inheritance[wallets[i]]);
        }
    }

    function died() public realOwner {
        alive = false;
        propertyTransfer();
    }
}
