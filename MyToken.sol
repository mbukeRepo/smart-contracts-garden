contract MyToken {
    address owner;
    mapping(address => uint) public tokenBalance;
    uint public tokenPrice = 1 ether;

    constructor () public {
        owner = msg.sender;
        tokenBalance[owner] = 100;
    }

    modifier onlyOwner () {
        require(msg.sender == owner, "You are not allowed");
        _;
    }

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable {
        require((totalBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
    }
}

// inheritance

contract Owned {
    address owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner () {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
}

contract MyToken is Owned {
    address owner;
    mapping(address => uint) public tokenBalance;
    uint public tokenPrice = 1 ether;

    constructor () public {
        tokenBalance[owner] = 100;
    }

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable {
        require((totalBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
    }
}

// importing 

// global importing
import "./owned.sol";

// import all members of a file
import * as symbolName from "./address.sol";

// import specific members
import {Owned as NewOwned} from "./owned.sol";

// on a real blockchain decoded output is invisible so we use events to 
// communicate to the outside

// Gas is what you pay for execution
// Gas for has categories 
// amount of gas is fixed
// gas price is not fixed it depends on how congested the network is

Solidity 6 updates.
// storage variables shadowing not allowed
contract A {
   uint a; // this has to be private to compile
}

contract B is A {
   uint a;
}

// not allowed to modify length of the array use push and pop to increase
// and decrease it.


