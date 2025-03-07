//
//  GameViewModel+GameInfo.swift
//  WHO'S THE SPY
//
//  Created by Motlaq Alnassafi on 06/03/2025.
//

extension GameViewModel {
    func getCategoryName() -> String {
        return currentCategoryItem?.name ?? "Unknown"
    }

    func getCategoryEmoji() -> String {
        return currentCategoryItem?.emoji ?? "School"
    }

    func getPlayerRoleDescription(_ player: Player) -> String {
        if player.isSpy {
            let spyText = getSpyDescription(excluding: player.name)
                       let roleText = "YouAreTheSpy".localized
                return "\(roleText)\(spyText)\n\n\(String(format: "FigureOutLocation".localized, getGameTypeText()))"
                   } else {
                       return "\(getGameTypeText()): \(currentCategoryItem?.name ?? "")\n\n\("PlayerRoleDescription".localized)"
                   }
    }
    
    func getSpyDescription(excluding playerName: String) -> String {
            if spyIndices.count > 1 && settingsManager.showSpiesToEachOther {
                let spyNames = players
                    .filter { $0.isSpy && $0.name != playerName }
                    .map { $0.name }
                
                return spyNames.isEmpty ? "" : "\n\n\("otherSpies".localized) \(spyNames.joined(separator: " \("and".localized) "))"
            }
            return ""
        }

    func getEndGameItemDescription() -> String {
        switch gameType {
        case .location:
            return "TheLocationWas".localized
        case .animal:
            return "TheAnimalWas".localized
        case .kuwaitAreas:
            return "TheAreaWas".localized
        }
    }

    func getPlayerRoleEmoji(_ player: Player) -> String {
        if player.isSpy {
            return "SpyCard"
        } else {
            return currentCategoryItem?.emoji ?? "Player"
        }
    }

    func getSuggestedQuestions() -> [(String, String)] {
        switch gameType {
        case .location:
            return [
                ("SuggestedQuestion1".localized, "eye"),
                ("SuggestedQuestion2".localized, "ear"),
                ("SuggestedQuestion3".localized, "activities"),
                ("SuggestedQuestion4".localized, "groupOfPeople"),
                ("SuggestedQuestion5".localized, "BusiestTime"),
            ]
        case .animal:
            return [
                ("SuggestedQuestionAnimal1".localized, "WhatAnimalDo"),
                ("SuggestedQuestionAnimal2".localized, "eye"),
                ("SuggestedQuestionAnimal3".localized, "ear"),
                ("SuggestedQuestionAnimal4".localized, "AnimalLive"),
                ("SuggestedQuestionAnimal5".localized, "AnimalActivities"),
            ]
        case .kuwaitAreas:
            return [
                ("SuggestedQuestionArea1".localized, "KuwaitGovernorate"),
                ("SuggestedQuestionArea2".localized, "RingRoad"),
                ("SuggestedQuestionArea3".localized, "CloseAreas"),
                ("SuggestedQuestionArea4".localized, "AreaSize"),
                ("SuggestedQuestionArea5".localized, "AreaDistance"),
            ]
        }
    }
    
    private func getGameTypeText() -> String {
            switch gameType {
            case .location:
                return "Location".localized
            case .animal:
                return "Animal".localized
            case .kuwaitAreas:
                return "Area".localized
            }
        }
}
