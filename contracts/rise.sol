pragma solidity >=0.5.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";

/// @dev This is the core behavior smart contract
/// for a non-fungible and decentralized cloud hosting service,
/// designed for freedom, privacy, and fair pricing

/// @title We All Rise
/// @author Dylan Finn
/// @notice draft and mvp design
/// @dev conforms to the ERC721 non-fungible token standard
contract Rise is Ownable {
    using SafeMath for uint256;
    using SafeMath for uint32;
    using SafeMath for uint16;
    using SafeMath for uint;

    uint perFactorFee = 0.001 ether;

    event NewNodelet(uint nodeletId, string name, string gitUrl, uint when);
    event InitializedNodelet(uint name, uint gitUrl, uint when);

    struct Nodelet {
        string name;
        string gitURL;
        string status;
        bool initialized;
        uint16 factor;
        uint256 dateCreated;
        uint256 dateInitialized;
        uint256 goodUntil;
    }

    /// @dev indexed by 1
    Nodelet[] public nodelets;

    mapping (uint => address) public nodeletToOwner;
    mapping (address => uint) ownerNodeletCount;

    modifier onlyOwnerOf(uint _nodeletId) {
        require(msg.sender == nodeletToOwner[_nodeletId], "Only the owner can manipulate a node");
        _;
    }

    // nodelet constructor
    /// @dev no logic relies on timestamps, so "now" is safe in this case
    function _newNodelet(string memory _name, string memory _url) internal {
        uint id = nodelets.push(Nodelet(_name, _url, "new", false, 0, 0, now, now));
        nodeletToOwner[id] = msg.sender;
        ownerNodeletCount[msg.sender] = ownerNodeletCount[msg.sender].add(1);
        emit NewNodelet(id, _name, _url, now);
    }

    /// @dev calculates when the nodelet is good until given it's factor and amount
    function _goodUntil(uint16 factor, uint256 amount) internal view returns (uint) {
        if (amount == 0) {
            return now;
        } else {
            uint until = amount.div(factor.mul(perFactorFee));
            until = until.mul(1 days);
            return until.add(now);
        }
    }

    // initialize a nodelet
    function _initializeNodelet(uint _id) external payable onlyOwnerOf(_id) {
        nodelets[_id].initialized = true;
        nodelets[_id].dateInitialized = now;
        nodelets[_id].goodUntil = _goodUntil(nodelets[_id].factor, msg.value);
    }
}