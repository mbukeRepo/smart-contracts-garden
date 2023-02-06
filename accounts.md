externally owned accounts and contract accounts.

externally owned accounts are the ones with private key. used to send funds and initiate
transactions. they live outside of the ethereum blockchain. they are not deployed contracts.

contract accounts cant initiate transactions only externally owned accounts.

contract accounts. They are inside the ethereum blockchain where code is run. they dont
have private key

re-entrancy danger ??

global objects

help understand where the transaction come from and what happens inside.

msg.sender address of the account who initiated the transaction.
msg.value how much ether were sent along.
now current timestamp.

a function cannot receive funds unless it's payable.

Starting stopping and deleting a smart contract.
How to allow only the owner of the smart contract (the one who called the smart cont) to 
be the only one to transfer funds.

```sol
  contract MyContract {
    address owner;
    // pausing a smart contract
    bool public paused;
    constructor() public {
        owner = msg.sender;
    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }

    function receiveFunds() public payable {

    }
    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        require(!paused, "This contract has been paused");
        _to.transfer(address(this).balance);
    } 
    // destroying a smart contract 
    function destroy(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
  }
```


Why is it impossible to completely delete all the data about smart  contract?
Smart contracts can be stopped (selfdestruct) but you can still see data about it.

Smart contract lifecycle.

Deploy => sendTransaction({from, to: empty, data})
          smart contract becomes his own address.
Interact 
        => sendTransaction({to: smartContractaddress, value, data})
Destroy / stop

Every smart contract get compiled and sent to the blockchain as a transaction(transaction based).
Transactions once mined are immutable.
Once deleted you can't interact with it anymore.