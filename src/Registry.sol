// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IMailbox.sol";

contract Registry {

    IMailbox inbox;
    mapping(address => mapping(bytes => bytes)) private data;

    event ReceivedMessage(uint32 origin, bytes32 sender, bytes message);

    constructor(address _inbox) {
        inbox = IMailbox(_inbox);
    }

    function handle(
        uint32 origin,
        bytes32 sender,
        bytes calldata message
    ) external {
        // decode message into (contractAddress, functionSignature, dataValue)
        (address contractAddress, bytes memory functionSignature, bytes memory dataValue) = abi.decode(message, (address, bytes, bytes));
        data[contractAddress][functionSignature] = dataValue;
        emit ReceivedMessage(origin, sender, message);
    }

    function readData(
        address contractAddress, 
        bytes memory functionSignature
    ) public view returns(bytes memory) {
        return data[contractAddress][functionSignature];
    }
}