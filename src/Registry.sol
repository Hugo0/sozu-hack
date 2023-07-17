// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Registry {

    mapping(address => mapping(bytes => bytes)) private data;

    function setData(
        address contractAddress, 
        bytes memory functionSignature, 
        bytes memory dataValue
    ) public {
        // TODO: this should be the function that is called by bridge relayer

        data[contractAddress][functionSignature] = dataValue;
    }

    function readData(
        address contractAddress, 
        bytes memory functionSignature
    ) public view returns(bytes memory) {
        return data[contractAddress][functionSignature];
    }
}