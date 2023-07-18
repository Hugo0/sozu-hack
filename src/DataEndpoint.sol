// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IMailbox.sol";
import "./interfaces/IInterchainGasPaymaster.sol";

contract DataEndpoint {

    // addresses are the same on all EVM chains
    IMailbox outbox = IMailbox(0xCC737a94FecaeC165AbCf12dED095BB13F037685);
    IInterchainGasPaymaster igp = IInterchainGasPaymaster(0xF90cB82a76492614D07B82a7658917f3aC811Ac1);
    event SentMessage(uint32 destinationDomain, bytes32 recipient, bytes data);

    function sendData(
        address contractAddress, 
        bytes memory encodedFunctionData,
        uint32 destinationDomain,
        bytes32 recipient
    ) public payable returns(bytes memory) {
        
        // call to contract and get response
        (bool success, bytes memory data) = contractAddress.call(encodedFunctionData);
        require(success, "Call failed");
        // TODO: do we want to revert transaction or just continue call fails?

        // encode relevant information
        bytes memory message = abi.encode(contractAddress, encodedFunctionData, data);

        bytes32 messageId = outbox.dispatch(destinationDomain, recipient, message);

        igp.payForGas{ value: msg.value }(
            messageId, // The ID of the message that was just dispatched
            destinationDomain, // The destination domain of the message
            1_000_000, // 1M gas to use in the recipient's handle function
            msg.sender // refunds go to msg.sender, who paid the msg.value
        );

        // emit event
        emit SentMessage(destinationDomain, recipient, message);

        return data;
    }
}
