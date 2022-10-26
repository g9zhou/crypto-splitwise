// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
// DO NOT MODIFY ABOVE THIS

// ADD YOUR CONTRACT CODE BELOW
    mapping (address => mapping (address => uint32) ) public balances;

    function lookup(address debtor, address creditor) public view returns (uint32) {
        return balances[debtor][creditor];
    }

    function add_IOU(address creditor, uint32 amount, address[] calldata cycle) public {
        address debtor = msg.sender;
        balances[debtor][creditor] += amount;
        uint32 amount_reduce = 2**32-1;
        for (uint32 i = 0; i < cycle.length; i++) {
            if (balances[cycle[i]][cycle[(i+1)%cycle.length]] < amount_reduce) {
                amount_reduce = balances[cycle[i]][cycle[(i+1)%cycle.length]];
            }
        }
        for (uint32 i = 0; i < cycle.length; i++) {
            balances[cycle[i]][cycle[(i+1)%cycle.length]] -= amount_reduce;
        }
    }
}
