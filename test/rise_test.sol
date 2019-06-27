pragma solidity >=0.5.0;
import "../contracts/Rise.sol";

contract RiseTest {

    Nodelet nodeletTest;
    function beforeAll () public {
       nodeletTest = _newNodelet("blah", "google.com");
    }
    
    function testNewNodelet () public view {
        Assert.equal(nodelets[nodeletTest].name, "blah", "Name should equal node's assigned name");

        Assert.equal(nodelets[nodeletTest].urlHash,
        uint(keccak256(abi.encodePacked("google.com"))),
        "Source URL hash does not match assigned url's hash");
    }
    
    function testInitializeNodelet () public view {
        _initializeNodelet(nodeletTest);
        Assert.equal(nodelets[nodeletTest].initialized, true, "Test node could not be initialized");
    }
}
