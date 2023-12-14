// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Quest.sol";

contract UserManagement {
    QuestNFT public questNFT;

    enum UserType { Student, Professor } // Student: 0 | Professor: 1

    struct User {
        string name;
        UserType userType;
        uint256[] questIds;
        uint256 totalXp;
        uint256 completedQuests;
        string[] skills;
    }

    mapping(address => User) private _users;

    constructor(address questNFTAddress) {
        questNFT = QuestNFT(questNFTAddress);
    }

    function createUser(string memory name, UserType userType, string[] memory skills) public {
        require(bytes(_users[msg.sender].name).length == 0, "User already exists");
        _users[msg.sender] = User(name, userType, new uint256[](0), 0, 0, skills);
    }

    function createQuest(string memory title, uint256 xp, string[] memory skills) public {
        require(_users[msg.sender].userType == UserType.Professor, "Only professors can create quests");
        uint quest_id = questNFT.createQuest(title, xp, skills, msg.sender);
        _users[msg.sender].questIds.push(quest_id);
    }

    function addQuestToUser(address userAddress, uint256 questId) public {
        // Check if the user exists and is eligible for the quest (optional)
        require(bytes(_users[userAddress].name).length != 0, "Student does NOT exists");
        require(_users[msg.sender].userType == UserType.Professor, "Only professors can successfully terminate quests");
        
        // Assign the quest to the user
        questNFT.assignQuestToUser(questId, userAddress);

        // Add XP and skills from the quest to the user
        QuestNFT.Quest memory completedQuest = questNFT.getQuest(questId);

        _users[userAddress].totalXp += completedQuest.xp;
        _users[userAddress].completedQuests++;
        _users[msg.sender].completedQuests++;

        for (uint i = 0; i < completedQuest.skills.length; i++) {
            if (!_skillExists(_users[userAddress].skills, completedQuest.skills[i])) {
                _users[userAddress].skills.push(completedQuest.skills[i]);
            }
        }

        // Add the questId to the user's questIds
        _users[userAddress].questIds.push(questId);
    }

    function _skillExists(string[] storage skills, string memory skill) private view returns (bool) {
        for (uint i = 0; i < skills.length; i++) {
            if (keccak256(abi.encodePacked(skills[i])) == keccak256(abi.encodePacked(skill))) {
                return true;
            }
        }
        return false;
    }

    function getUser(address userAddress) public view returns (User memory) {
        return _users[userAddress];
    }

    function getUserQuests(address userAddress) public view returns (uint256[] memory) {
    return _users[userAddress].questIds;
}
}
