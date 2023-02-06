// Any one can deposit
// Withdrawal:
//   owner: unlimited"
//   non-owner: Depending on the allowable variable
// Change allowance: only the owner

// import safe math from openzepplin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowable is Ownable {
   using SafeMath for uint256;

   event AllowanceChanged(address indexed _forwho, address indexed _fromwho, uint _oldamount, uint _newamount);

   mapping (address => uint) public allowance;

   function addAllowance(address _who, uint _amount) public onlyOwner {
      emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
      allowance[_who] = _amount
   }

   modifier ownerOrAllowed(uint _amount) {
      require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed")
      _;
   }

   function reduceAllowance(address _who, uint _amount) internal {
      emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
      allowance[_who] = allowance[_who].sub(_amount)
   }
}

contract SharedWallet is Allowable {
   event MoneySent(address indexed _beneficiary, uint _amount);
   event MoneyReceived(address indexed _from, uint _amount);

   function withdraw(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
      require(_amount <= address(this).balance, "There are no enough funds in the smart contract");
      if(!isOwner()) {
        reduceAllowance(msg.sender, _amount);
      }
      emit MoneySent(_to, _amount);
      _to.transfer(_amount);
   } 

   // kill the renounceOwnership functionality
   function renounceOwnership() public onlyOwner {
      revert("Can't renounce ownership here");
   }

   receive() external payable {
      emit MoneyReceived(msg.sender, msg.value)
   } 
}