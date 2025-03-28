//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {Raffle} from "../../src/Raffle.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract RaffleTest is Test {

    Raffle public raffle;
    HelperConfig public helperConfig;

    uint256 entranceFee;
    uint256 interval;
    address vrfCoordinator;
    bytes32 gasLane;
    uint32 callbackGasLimit;
    uint256 subscriptionId;    

    address public PLAYER = makeAddr("player");
    uint256 public constant STARTING_PLAYER_BALANCE = 10 ether;

    event RaffleEnterd(address indexed player);
    event WinnerPicked(address indexed winner);
    
    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();
        (raffle,helperConfig)=deployer.deployContract();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();
        entranceFee = config.entranceFee;
        interval = config.interval;
        vrfCoordinator = config.vrfCoordinator;
        gasLane = config.gasLane;
        callbackGasLimit = config.callbackGasLimit;
        subscriptionId = config.subscriptionId;

        vm.deal(PLAYER,STARTING_PLAYER_BALANCE); // Adding funds to Player
    }
    function testRaffleInitializesInOpenState() public view {
        assert(raffle.getRaffleState()== Raffle.RaffleState.OPEN);
    }

    function testRaffleRevertsWhenYouDontPayEnough() public {
        // Arrange
        vm.prank(PLAYER);
        // Act /Assert
        vm.expectRevert(Raffle.Raffle__SendMoreToEnterRaffle.selector);
        raffle.enterRaffle();
    }

    function testRaffleRecordsPlayersWhenTheyEnter() public {
        // Arrange
        vm.prank(PLAYER);
        vm.deal(PLAYER, 10 ether);
        // Act
        raffle.enterRaffle{value : entranceFee}();

        // Assert
        address playerRecorded = raffle.getPlayers(0);
        assert(playerRecorded ==PLAYER);
    }

    function testEnteringRaffleEmitsEvent() public {
        // Arrange
        vm.prank(PLAYER);
        //Act
        // 1stindex topic, 2nd, 3rd, non-indexed parameters, address
        vm.expectEmit(true,false,false,false, address(raffle));
        emit RaffleEnterd(PLAYER);
        // Assert
        raffle.enterRaffle{value : entranceFee}();
    }

}