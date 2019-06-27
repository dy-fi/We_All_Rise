pragma solidity >=0.5.0;

import "./rise.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

/// @dev Rise nodelet token behavior
contract RiseOwnership is Rise, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) nodeletApprovals;

  function balanceOf(address _owner) public view returns (uint256) {
    return Rise.ownerNodeletCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address) {
    return nodeletToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerNodeletCount[_to] = ownerNodeletCount[_to].add(1);
    ownerNodeletCount[msg.sender] = ownerNodeletCount[msg.sender].sub(1);
    nodeletToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) public {
      require (nodeletToOwner[_tokenId] == msg.sender || nodeletApprovals[_tokenId] == msg.sender, "This needs to be ");
      _transfer(_from, _to, _tokenId);
    }

  function approve(address _approved, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
      nodeletApprovals[_tokenId] = _approved;
      emit Approval(msg.sender, _approved, _tokenId);
    }
}
