pragma solidity^0.0 .141;

contract token{

    event Approval(address indexed tokenowner, address indexed user/client, uint tokens);
    event Transfer(address indexed sender, address indexed to, uint tokens);
    event Personalemoval(address indexed removed, address indexed attachedTo, Role indexed to role);
    event HolderAdd(address indexed added);
}

uint256 _totalsupply;
mapping(address => uint256) _balances; //mapping of accounts and their balances
mapping (address=> mapping(address =>uint256))  _allowed; //mapping of acccounts allowed to withdraw from a given account and their balances
address[] _holders; //all token holders
address[] _appointees; //who have right to transfer their representee's token to another account
address _owner;

enum Role {Holder, Appointee, Owner}

constructor() public payable {
    _totalsupply = 1000000;
    _holders.push(msg.sender);
    _balances[msg.sender] = totalsupply;
    _owner = msg.sender;
    
    }

    /*Total token amount at creation time 
     */
     function totalsupply() public view returns(uint256){
        return _totalsupply;
     }

function balanceof(address tokenOwner) public view returns(uint){
    return _balances[tokenOwner];
}

/*Total withdrawal by appointee cannot exceed allowance.
Allowance remains unchanged untill the holder change it.
*/
function allowance(address tokenOwner, address appointee) public view returns(uint){
    return _allowed[tokenOwner][appointee];
}

function transfer(address to, uint transferamount) public payable returns(bool){
    transferFrom(msg.sender, to, transferamount);
    return true;
}

function transferFrom(address provenance, address receiver, uint transferAmount) public payable returns (bool){
    require(holderExist(provenance), "Debitor is not a holder,");
    require(holderExist(reciever), "Reciever is not a holder. please add new account before transfering tokens to this account,");
    require(_balances[provenance] >= transferAmount, "Balance not enough");
    if(msg.sender !=provenance){
        require(_allowed[provenance][msg.sender] >= transfer amount, "Not enough tokens authorised")
    }
    _balances[provenance] = _balances[provenance]- transferAmount;
    _balances[reciever] = _balances[receiver] + transferAmount;

  emit Transfer(provenance, reciever, transferAmount);
  return true;
}
function approve(address appointee, uint withdrawAmount) public payable returns (bool){
    require(checkHolderPermission(msg.sender), "Account not authorised");
    require(_balances[msg.sender] >= withdrawAmount, "Balance not enough");
      allowed(msg.sender, appointee, withdrawAmount);
      return true;
      
}
function holderExist(address accountTocheck) public view returns (bool)
    for(uint i =0; i<_holders.length; i++)
         if(holders[i] ==accountTocheck)
         return true;

    return false;

function addHolder(address accountToAdd) public returns (bool){
    require(!holderExists(accountToAdd), "Holder already exists.")
    require(checkHolderPermission(msg.sender), "Not authorised");
    _holders.push(accountToAdd);
    assert(holdersExists(accountToAdd));

    emit HolderAdd(accountToAdd);
    return true;
}     
          
 /*Only contracts owner can remove a holder.
 */
 function removaHolder(address toRemove) public returns (bool){
    require(checkOwnerPermissions(msg.sender), "Not authorised.")
    require(holderExist(toRemove), "Holder not exist");
    require(_balance[toRemove] ==0, "Balance is not 0, please trransfer all credit to anotheraccount before remove. ");
    uint index;
    for(uint i = 0; i<_holders.length; i++){
        if(_holders[i] == toRemove){
            index = i;
        }
        
    }
 
 uint256 arrlen = _holders.length;
 delete _holders[index];
 _holders[index] = _holders[arrlen - 1];
 _holders.lenght..;

 emit personRemoval(toRemove, address(0), Role.Holder);
 return true;

}
/*only appointee's holdr can remove him.
*/
function removeAppointee(address toRemove) public returns (bool){
    require(checkHolderPermission(msg.sender), "Not authorised as a holder or owner of contract.");
    require(_allowed[msg.sender][toRemove] !=0, "Not authorised to remove appointee.");
    _allowed[msg.sender][toRemove] = 0;
    
    emit personalRemoval(toRemove, msg.sender, Role.appointeee)
    return true;

}

function checkHolderPermissions(address tocheck) public view returns (bool){
    return (holderExist(tocheck));

}
function checkOwnerPermission(address tocheck) publiv view returns (bool){
    return (toCheck == _owner);

}

function CheckAppointeePermission(address toCheck, address mapToOwner) public view returns (bool){

}

function getOwner() public view returns(address pwner){
    return _Owner;
}



    

    















































}



