// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import "../src/DataEndpoint.sol";

contract DataEndpointTest is Test {
    DataEndpoint public dataEndpoint;

    uint256 mainnetId;
    string constant MAINNET_RPC_URL = "https://eth-mainnet.g.alchemy.com/v2/ytr14v4BnB2qISBJIE4YxjIgYad55FHl";
    address constant AXELAR_MAINNET_GATEWAY = 0x4F4495243837681061C4743b74B3eEdf548D56A5
    address constant AXELAR_MAINNET_GAS_SERVICE = 0x2d5d7d31F671F86C782533cc367F14109a082712
    address constant AXELAR_OPTIMISM_GATEWAY = 0xe432150cce91c13a887f7D836923d5597adD8E31
    address constant AXELAR_OPTIMISM_GAS_SERVICE = 0x2d5d7d31F671F86C782533cc367F14109a082712

    function setUp() public {
        mainnetId = vm.createFork(MAINNET_RPC_URL, 17_714_587); // block number 17_714_587
        vm.selectFork(mainnetId);
        dataEndpoint = new DataEndpoint();
    }

    function testDataEndpoint_canRead() external {        
        bytes memory functionSignature = abi.encodeWithSignature("balanceOf(address)", 0x7A9fe22691c811ea339D9B73150e6911a5343DcA);
        address contractAddress = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D; // BAYC contract address
        
        bytes memory result = dataEndpoint.sendData(contractAddress, functionSignature);
        uint256 balance = abi.decode(result, (uint256));
        assertEq(balance, 31); // the address hold 31 BAYC tokens at block 17_714_587
    }
}
