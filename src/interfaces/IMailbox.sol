// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IMailbox {
    function dispatch(uint32 destinationDomain, bytes32 recipient, bytes memory data) external;
}