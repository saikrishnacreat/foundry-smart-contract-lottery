// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {CreateSubscription} from "../../script/Interactions.s.sol";
import {FundSubscription} from "../../script/Interactions.s.sol";
import {AddConsumer} from "../../script/Interactions.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";
import {LinkToken} from "../mocks/LinkToken.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract SubscriptionScriptsTest is Test {
    CreateSubscription createSub;
    FundSubscription fundSub;
    AddConsumer addConsumer;
    HelperConfig helperConfig;
    
    address public vrfCoordinator;
    address public linkToken;
    address public account;
    uint256 public subscriptionId;
    
    function setUp() public {
        createSub = new CreateSubscription();
        fundSub = new FundSubscription();
        addConsumer = new AddConsumer();
        helperConfig = new HelperConfig();
        
        // Get config values
        vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        linkToken = helperConfig.getConfig().link;
        account = helperConfig.getConfig().account;
    }
    function testCreateSubscription() public {
    // Act
    (uint256 newSubId, ) = createSub.createSubscriptionUsingConfig();
    // Assert
    assertTrue(newSubId > 0, "Subscription ID should be greater than 0"); 
}
}