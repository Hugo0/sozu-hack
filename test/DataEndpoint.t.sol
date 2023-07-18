// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import "../src/DataEndpoint.sol";

contract DataEndpointTest is Test {
    // DataEndpoint public dataEndpoint;

    // uint256 mainnetId;
    // string constant MAINNET_RPC_URL = "https://eth-mainnet.g.alchemy.com/v2/ytr14v4BnB2qISBJIE4YxjIgYad55FHl";

    // function setUp() public {
    //     mainnetId = vm.createFork(MAINNET_RPC_URL, 17_714_587); // block number 17_714_587
    //     vm.selectFork(mainnetId);
    //     dataEndpoint = new DataEndpoint();
    // }

    // function testDataEndpoint_canRead() external {        
    //     bytes memory functionSignature = abi.encodeWithSignature("balanceOf(address)", 0x7A9fe22691c811ea339D9B73150e6911a5343DcA);
    //     address contractAddress = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D; // BAYC contract address
        
    //     bytes memory result = dataEndpoint.sendData(contractAddress, functionSignature);
    //     uint256 balance = abi.decode(result, (uint256));
    //     assertEq(balance, 31); // the address hold 31 BAYC tokens at block 17_714_587
    // }

    // DataEndpoint dataEndpoint;

    function testConstructData() external {
        bytes memory functionSignature = abi.encodeWithSignature("balanceOf(address)", 0x5777372A6BbBB0b0903aA5325094F390803f80D6);
        console.logBytes(functionSignature);
        address contractAddress = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F; // USDC contract address
        console.logBytes32(bytes32(uint256(uint160(0xfe5CD4EB9748C62B6B3edd36FA6c033c95D2f685))));
    }
}
