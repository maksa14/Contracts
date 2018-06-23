pragma solidity ^0.4.24;

contract ERC20Interface {
    function totalSupply() public constant returns (uint256);
    function balanceOf(address _owner) public constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) public returns (bool success);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}

contract Token is ERC20Interface {
    string public constant symbol = "TEST";
    string public constant name = "My Testing Token";
    uint8 public constant decimals = 0;
    uint256 _totalSupply = 1000000;
    
    mapping (address => uint256) balances;

    address public owner;

    constructor() public {
        owner = msg.sender;
        balances[owner] = _totalSupply;
    }

    function totalSupply() public constant returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balances[_owner];
    }
    
    function transfer(address _to, uint256 _amount) public returns (bool success) {
        if (balances[msg.sender] >= _amount
        && _amount > 0
        && balances[_to] + _amount > balances[_to]) {
            balances[msg.sender] -= _amount;
            balances[_to] += _amount;
            emit Transfer(msg.sender, _to, _amount);
            return true;
        }
        else {
            return false;
        }
    }
    
}

contract Crowdsale {
    Token public token;
    
    constructor(address _token) public {
        token = Token(_token);
    }
    
    function () public payable {
        transferToken(msg.sender, msg.value);
    }
    
    function tokenAddress() public view returns (address) {
        return token;
    }
    
    function transferToken (address _to, uint256 _tokenAmount) public returns (bool) {
        return token.transfer(_to,_tokenAmount);
    }
}