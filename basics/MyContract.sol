contract MyContract {
  string public value;
  string public constant name = "Hello";
  constructor() public {
    value = "value";
  } 

  function get() public view returns(string) {
    return value;
  }

  function set(string _value) public {
    value = _value;
  }
};
 
