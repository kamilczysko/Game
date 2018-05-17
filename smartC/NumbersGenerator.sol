pragma solidity ^0.4.23;

import "./NumberLib.sol";

contract RandomArrayGenerator{
    
    uint private nonce = 0;

    function getRandomArray(uint24 size, uint winner) public returns(uint8[]){
        
        uint8[] memory array = new uint8[](size);
        uint random_number = uint(blockhash(block.number-1))%10;
            
        for(uint i = 0; i<size; i++){
            array[i] = Generator.generateSingleNumber(nonce, winner);
            nonce += random_number;
            
            if(nonce > uint(block.timestamp/256)){
                nonce = block.timestamp%563;
            }
        }
        
        return array;
    }
    
    
}
