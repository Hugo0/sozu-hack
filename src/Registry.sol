// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interfaces/IMailbox.sol";

contract Registry {

    IMailbox inbox = IMailbox(0xCC737a94FecaeC165AbCf12dED095BB13F037685);
    address dataEndpointAddress;
    ///@dev mapping of hash(contractAddress,chainId) of source chain to encoded function signature to data
    mapping(bytes32 => mapping(bytes => bytes)) private data;

    event ReceivedMessage(uint32 origin, bytes32 sender, bytes message);

    constructor(address _dataEndpointAddress) {
        dataEndpointAddress = _dataEndpointAddress;
    }

    function handle(
        uint32 origin,
        bytes32 sender,
        bytes calldata message
    ) external {
        require(sender == bytes32(uint256(uint160(dataEndpointAddress))), "Sender is not data endpoint");
        // decode message into (contractAddress, functionSignature, dataValue)
        (address contractAddress, bytes memory functionSignature, bytes memory dataValue) = abi.decode(message, (address, bytes, bytes));
        bytes32 identifier = keccak256(abi.encodePacked(contractAddress, origin));
        data[identifier][functionSignature] = dataValue;
        emit ReceivedMessage(origin, sender, message);
    }

    function readData(
        address contractAddress, 
        uint256 chainId,
        bytes memory encodedFunctionSignature
    ) public view returns(bytes memory) {
        bytes32 identifier = keccak256(abi.encodePacked(contractAddress, chainId));
        return data[identifier][encodedFunctionSignature];
    }
}