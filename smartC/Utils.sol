pragma solidity ^0.4.23;

library Utils{
    
    function areEqual (uint8[] _a, uint8[] _b) internal pure returns (bool){
           for (uint i = 0; i < _a.length; i++){
               if(_a[i] != _b[i]){
                   return false;
               }
           }
        return true;
    }
    
    function generateSingleNumber(uint nonce, uint winner) internal view returns (uint8) {
        return uint8(uint256(keccak256((block.timestamp+nonce+winner)/2 , block.difficulty))%9);
    }	

}
