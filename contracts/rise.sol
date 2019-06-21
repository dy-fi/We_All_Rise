pragma solidity >=0.5.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";

/// @dev This is the core behavior smart contract
/// for a non-fungible and decentralized cloud hosting service,
/// designed for freedom, privacy, and fair pricing

/// @title We All Rise
/// @author Dylan Finn
/// @notice prototype
/// @dev conforms to the ERC721 non-fungible token standard
contract Rise is Ownable {
    using SafeMath for uint256;
    using SafeMath for uint32;
    using SafeMath for uint16;
    using SafeMath for uint;

    event NewNodelet(uint siteId, string name, uint hash);

    uint idSize = 16;
    uint idModulus = 10 ** idSize;

    struct Nodelet {
        bool initialized;
        string name;
        string gitURL;
        string status;
        uint updated;
        uint dateInitialized;
        uint16 interval;
    }

    Nodelet[] public nodelets;

    mapping (uint => address) public nodeletToOwner;
    mapping (address => uint) ownerNodeletCount;

    function _newNodelet(string memory _name, uint _id) internal {
        
    }

    function _initializeNodelet(uint _id) internal {
        
    }
}