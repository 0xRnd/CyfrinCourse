// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
    address public immutable i_owner;
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough USD"); 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    } 

    function withdraw() public onlyOwner{
        for (uint256 funderIndex=0;funderIndex>funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        (bool success,) = payable (msg.sender).call{value: address(this).balance}("");
        require(success,"Call failed");
    }   

    modifier onlyOwner(){
        require(msg.sender == i_owner,"Sender is not owner");
        _;
    }

    receive() external payable { 
        fund();
    }
    fallback() external payable {
        fund();
     }
}