pragma solidity >=0.5.0;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";

/// @notice This is the core behavior smart contract
/// for a non-fungible and decentralized cloud hosting service,
/// designed for freedom, privacy, and fair pricing

/// @title We All Rise
/// @author Dylan Finn
/// @notice draft and mvp design
/// @dev conforms to the ERC721 non-fungible token standard
/// @dev Rise contract behavior and framework
contract Rise is Ownable {
    using SafeMath for uint256;
    using SafeMath for uint32;
    using SafeMath for uint16;
    using SafeMath for uint;

    event NewNodelet(uint nodeletId, string name, string urlHash, uint when);
    event InitializedNodelet(uint name, uint urlHash, uint when);

    struct Nodelet {
        string name;
        string urlHash;
        string status;
        bool initialized;
        uint16 factor;
        uint256 dateCreated;
        uint256 dateInitialized;
        uint256 goodUntil;
    }

    /// @notice indexed by 1
    Nodelet[] public nodelets;

    mapping (uint => address) public nodeletToOwner;
    mapping (address => uint) ownerNodeletCount;

    modifier onlyOwnerOf(uint _nodeletId) {
        require(msg.sender == nodeletToOwner[_nodeletId], "Only the owner can manipulate a node");
        _;
    }

    /// @dev nodelet constructor
    /// @notice no logic relies on timestamps, so "now" is safe in this case
    /// @param name new node name
    /// @param _url github url with source code
    function _newNodelet(string memory _name, string memory _url) internal {
        uint _urlHash = uint(keccak256(abi.encodePacked(_url)));
        uint id = nodelets.push(Nodelet(_name, _urlHash, "new", false, 0, 0, now, now));
        nodeletToOwner[id] = msg.sender;
        ownerNodeletCount[msg.sender] = ownerNodeletCount[msg.sender].add(1);
        emit NewNodelet(id, _name, _url, now);
    }

    /// @dev calculates when the nodelet is good until given it's factor and amount
    /// @notice timestamp logic uses safemath and the node does not run until initialized anyways
    /// @param factor is the integer representation of the current resources this node uses
    /// @param amount is the amount paid towards the goodUntil date
    function _goodUntil(uint16 factor, uint256 amount) internal view returns (uint) {
        if (amount == 0) {
            return now;
        } else {
            uint until = amount.div(factor.mul(perFactorFee));
            until = until.mul(1 days);
            return until.add(now);
        }
    }

    /// @dev initialize a nodelet
    /// @notice no logic relies on timestamps, so "now" is safe in this case
    function _initializeNodelet(uint _id) external payable onlyOwnerOf(_id) {
        Nodelet curr = nodelets[_id];
        curr.initialized = true;
        curr.dateInitialized = now;
        curr.goodUntil = _goodUntil(nodelets[_id].factor, msg.value);
        emit InitializedNodelet(curr.name, curr.gitUrl, now);
    }
}