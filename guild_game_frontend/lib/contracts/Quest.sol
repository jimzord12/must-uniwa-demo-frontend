// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract QuestNFT is ERC721, Ownable {
    using Counters for Counters.Counter;

    struct Quest {
        string title;
        address createdBy;
        address assignedTo;
        uint256 xp;
        string[] skills;
    }

    Counters.Counter private _tokenIds;
    mapping(uint256 => Quest) private _quests;

    constructor() ERC721("QuestNFT", "QUEST") {}

    function createQuest(string memory title, uint256 xp, string[] memory skills, address professor) public returns (uint256) {
        _tokenIds.increment();
        uint256 newQuestId = _tokenIds.current();
        _mint(professor, newQuestId);
        _quests[newQuestId] = Quest(title, professor, address(0), xp, skills);
        return newQuestId;
    }

    function assignQuest(uint256 questId, address assignee) public {
        require(ownerOf(questId) != msg.sender, "Not the quest owner");
        _quests[questId].assignedTo = assignee;
    }

    function assignQuestToUser(uint256 questId, address user) public {
        require(ownerOf(questId) != msg.sender, "Not the quest owner");
        _quests[questId].assignedTo = user;
    }

    function getQuest(uint256 questId) public view returns (Quest memory) {
        return _quests[questId];
    }
}
