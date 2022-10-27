// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
// DO NOT MODIFY ABOVE THIS

// ADD YOUR CONTRACT CODE BELOW
    mapping (address => mapping(address => uint32)) balances;
    function lookup(address debtor, address creditor) public view returns (uint32 ret)
    {
        return balances[debtor][creditor];
    }

    function add_IOU(address creditor, uint32 amount, address[] calldata cycle, uint32 amount_reduce) public
    {
        balances[msg.sender][creditor] += amount;
        for (uint32 i = 0; i < cycle.length; i++) {
            balances[cycle[(i+1)%cycle.length]][cycle[i]] -= amount_reduce;
        }
        // todo: add security check
    }
}
