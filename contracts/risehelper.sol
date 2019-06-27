pragma solidity >=0.5.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./Rise.sol";

/// @title RiseHelper
/// @dev Rise contract business and data logic
contract RiseHelper is Rise {

    uint perFactorFee = 0.001 ether;

    /// @dev set the per-factor fee
    function setPerFactorFee(uint _fee) external onlyOwner {
        perFactorFee = _fee;
    }

    /// @dev change a nodelets name
    function changeName(uint _nodeletId, string _newName) external onlyOwnerOf(_nodeletId) {
        nodelets[_nodeletId].name = _newName;
    }

    /// @dev change the nodelets source url hash
    function changeUrl(uint _nodeletId, string _newUrl) external onlyOwnerOf(_nodeletId) {
        nodelets[_nodeletId].urlHash = uint(keccak256(abi.encodePacked(_newUrl)));
    }

    /// @dev get all nodelets owned by an account
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