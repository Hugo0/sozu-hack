// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IMailbox.sol";

contract DataEndpoint {

    IMailbox outbox;
    event SentMessage(uint32 destinationDomain, bytes32 recipient, bytes data);

    constructor(address _outbox) {
        outbox = IMailbox(_outbox);
    }

    function sendData(
        address contractAddress, 
        bytes memory encodedFunctionData,
        uint32 destinationDomain,
        bytes32 recipient
    ) public returns(bytes memory) {
        
        // call to contract and get response
        (bool success, bytes memory data) = contractAddress.call(encodedFunctionData);
        require(success, "Call failed");
        // TODO: do we want to revert transaction or just continue call fails?

        // encode relevant information
        bytes memory message = abi.encode(contractAddress, encodedFunctionData, data);

        outbox.dispatch(destinationDomain, recipient, message);
        emit SentMessage(destinationDomain, recipient, message);

        return data;
    }
}
