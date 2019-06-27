pragma solidity >=0.5.0;

import "./Rise.sol";

contract RiseHelper is Rise {

    function getNodeletsByOwner(address _owner) external view returns (uint[] memory) {
        uint[] memory result = new uint[](ownerNodeletCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < nodelets.length; i++) {
            if (nodeletToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}