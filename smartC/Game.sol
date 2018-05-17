pragma solidity ^0.4.23;

import "./UtilLib.sol";
import "./NumbersGenerator.sol";

contract GameLogic{
    
    RandomArrayGenerator private arrayGenerator = new RandomArrayGenerator();
    
    uint private addresses; 
    address private myAddress;
    uint8 [] randomArray;
    uint24 randomArraySize = 5;
    
    function () public payable{}
    
    constructor() public{
        myAddress = msg.sender;
        addresses = uint(myAddress);
        generateNewArray(randomArraySize);
       
    }
    
    modifier minimalBet(){
        require(msg.value >= 0.001 ether);
        _;
    }

    function play(uint8[] _array) public payable minimalBet returns(string) {
        uint value = msg.value;
        //require(value > 0.001 ether);
        address winner = msg.sender;
        if(guess(_array)){
            //randomArraySize = randomArraySize + uint24(getBalance()/1000000000);
            sendAwards(winner, value);
            combineAddress(winner);
            generateNewArray(randomArraySize);
            return ("wygrana");
        }
        
        return ("dupa");
    }
    
    function generateNewArray(uint24 _size) public {
         randomArray = arrayGenerator.getRandomArray(_size, addresses);
    }
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function combineAddress(address _winner) private{
        addresses = (uint(_winner)+addresses)/block.timestamp;
    }
    
    function getNum() public view returns(uint8[]){
        return randomArray;
    }
    
    function guess(uint8[] _guess) public view returns(bool) {
        return(Utils.areEqual(_guess, randomArray));
    }
    
    function sendAwards(address _winner, uint _value) private {
        uint actualBalance = getBalance();
        myAddress.transfer(uint(actualBalance/5));
        _winner.transfer(uint(actualBalance/2));
    }

    
    
}
