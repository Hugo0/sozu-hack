// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract DataEndpoint {

    function sendData(address contractAddresses, bytes memory encodedFunctionData) public returns(bytes memory) {
        
        // call to contract and get response
        (bool success, bytes memory data) = contractAddresses.call(encodedFunctionData);
        require(success, "Call failed");
        // TODO: do we want to revert transaction or just continue if one of the calls fails?

        return data;

        // TODO: call to bridge and pass data
    }
    
}
