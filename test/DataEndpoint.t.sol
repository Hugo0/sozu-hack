// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import "../src/DataEndpoint.sol";
import "../src/Registry.sol";

contract DataEndpointTest is Test {
    DataEndpoint public dataEndpoint;
    Registry public registry;

    function setUp() public {
        // TODO: deploy to goerli chain
        dataEndpoint = new DataEndpoint();
        // TODO: deploy to optimism goerli chain
        registry = new Registry();
    }

    function testDataEndpoint_canRead() external {  
        // TODO: connect to goerli chain      
        bytes memory functionSignature = abi.encodeWithSignature("balanceOf(address)", 0x5777372A6BbBB0b0903aA5325094F390803f80D6);
        address contractAddress = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F; // USDC contract address
        bytes memory expectedData = dataEndpoint.sendData(contractAddress, functionSignature, 420, bytes32(uint256(uint160(address(registry)))));

        // TODO: switch to optimism goerli chain
        bytes memory data = registry.readData(contractAddress, functionSignature);
        assertEq(data, expectedData);
    }
}
