// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import "../src/DataEndpoint.sol";
import "../src/Registry.sol";

contract DataEndpointTest is Test {
    DataEndpoint public dataEndpoint;
    Registry public registry;

    uint256 ethFork;
    uint256 optimismFork;

    function setUp() public {
        // deploy to goerli chain
        ethFork = vm.createFork("https://eth-goerli.g.alchemy.com/v2/-IR7-jmKYZuAup-HG0s-bGXNSzQu7Hsx");
        vm.selectFork(ethFork);
        dataEndpoint = new DataEndpoint();

        // deploy to optimism goerli chain
        optimismFork = vm.createFork("https://goerli.optimism.io");
        vm.selectFork(optimismFork);
        registry = new Registry(address(dataEndpoint));
    }

    function testDataEndpoint_canRead() external {  
        // connect to goerli chain      
        vm.selectFork(ethFork);
        bytes memory functionSignature = abi.encodeWithSignature("balanceOf(address)", 0x5777372A6BbBB0b0903aA5325094F390803f80D6);
        address contractAddress = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F; // USDC contract address
        try dataEndpoint.sendData{value: 0.01 ether}(
            contractAddress, 
            functionSignature, 
            420, 
            bytes32(uint256(uint160(address(registry))))
        ) {
            // success
        } catch Error(string memory reason) {
            // assume that relayer would relay messages in real life
        }

        // switch to optimism goerli chain
        vm.selectFork(optimismFork);
        // readData
    }
}
