pragma solidity >=0.5.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./Rise.sol";

contract RiseHelper is Rise {

    uint perFactorFee = 0.001 ether;

    function setPerFactorFee(uint _fee) external onlyOwner {
        perFactorFee = _fee;
    }

    function changeName(uint _nodeletId, string _newName) external onlyOwnerOf(_nodeletId) {
        nodelets[_nodeletId].name = _newName;
    }

    function changeUrl(uint _nodeletId, string _newUrl) external onlyOwnerOf(_nodeletId) {
        nodelets[_nodeletId].gitUrl = _newUrl;
    }

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