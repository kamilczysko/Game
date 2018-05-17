pragma solidity ^0.4.23;
    
library Generator{
        
    function generateSingleNumber(uint nonce, uint winner) internal view returns (uint8) {
        return uint8(uint256(keccak256((block.timestamp+nonce+winner)/2 , block.difficulty))%9);
    }
}
