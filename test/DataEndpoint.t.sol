// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import "../src/DataEndpoint.sol";

contract DataEndpointTest is Test {
    DataEndpoint public dataEndpoint;

    function setUp() public {
        dataEndpoint = new DataEndpoint();
    }

    function testDataEndpoint_canRead() external {
        bytes memory functionSignature = abi.encodeWithSignature("balanceOf(address)", 0x7A9fe22691c811ea339D9B73150e6911a5343DcA);
        address contractAddress = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
        bytes memory result = dataEndpoint.sendData(contractAddress, functionSignature);
        console.logBytes(result);
    }
}
