//raffel

//enter the lottery

//pick a random winner

//automate the selection of randomness

//chainlink oracle

//SPDX-Licence-Identifier : MIT

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
error Raffel__notEnoughEth();

contract Raffle is VRFConsumerBaseV2 {
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    VRFCoordinatorV2Interface private immutable vrfCordinator;

    event raffelEnter(address indexed player);

    constructor(address vrfCordinatorV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCordinatorV2) {
        i_entranceFee = entranceFee;
        vrfCordinator = VRFCoordinatorV2Interface(vrfCordinatorV2);
    }

    function enterRaffel() public payable {
        if (msg.value < i_entranceFee) {
            revert Raffel__notEnoughEth();
        }
        s_players.push(payable(msg.sender));

        //Events
        emit raffelEnter(msg.sender);
    }

    function pickRandomWinner() external {}

    function fulfillRandomWords(
        uint256, /* requestId */
        uint256[] memory randomWords
    ) internal override {}

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }
}
