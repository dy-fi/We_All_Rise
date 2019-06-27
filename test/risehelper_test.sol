pragma solidity >=0.5.0;
import "../contracts/RiseHelper.sol";

contract RiseHelperTest {

    Nodelet nodeletTest;
    function beforeAll () public {
       nodeletTest = _newNodelet("blah", "google.com");
       _initalizeNodelet(nodeletTest);
    }
    
}
