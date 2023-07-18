// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IInterchainGasPaymaster {
    function payForGas(
        bytes32 messageId,
        uint32 destinationDomain,
        uint256 gasLimit,
        address refundAddress
    ) external payable;
}