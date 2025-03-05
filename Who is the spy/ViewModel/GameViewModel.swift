//
//  GameViewModel.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import Combine
import Foundation
import SwiftUICore
import UIKit

class GameViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var gameState: GameState = .setup
    @Published var gameType: GameType = .location
    @Published var currentPlayerIndex: Int = -1
    @Published var timer: AnyCancellable?
    @Published var remainingSeconds: Int = 8 * 60
    @Published var winnerRole: String = ""
//    @Published var showVotingSheet = false
    @Published var showingIntro = true
    @Published var hapticFeedback = true
    @Published var soundEffects = true
    @Published var customPlayerNames = false
    @Published var editablePlayerNames: [String] = []
    @Published var playerCount = 0
    @Published var spyCount = 0
    @Published var category: [CategoryItem] = CategoryItem.generalLocations
    @Published var showSpiesToEachOther: Bool = false

    private var currentCategoryItem: CategoryItem?
    private var usedEmojis = Set<String>()
    private var currentIndex = 0
    var spyIndices = Set<Int>()

    enum GameState {
        case gameType
        case setup
        case roleReveal
        case playing
        case finished
    }

    enum GameType {
        case location
        case animal
        case kuwaitAreas
    }

    func getCategoryItem() -> CategoryItem? {
        guard currentIndex < category.count else {
            category.shuffle()
            currentIndex = 0
            return returnCategoryItem()
        }
        return returnCategoryItem()
    }

    func returnCategoryItem() -> CategoryItem {
        let location = category[currentIndex]
        currentIndex += 1
        return location
    }

    func setupGame(playerCount: Int, spyCount: Int) {
        guard spyCount < (playerCount + 1) / 2 else { return }
        currentCategoryItem = getCategoryItem()
        usedEmojis.removeAll()
        editablePlayerNames.removeAll()
        var newPlayers: [Player] = []
        for i in 0 ..< playerCount {
            let emoji = getUniqueEmoji()
            newPlayers.append(Player(
                name: customPlayerNames ? "\("Player".localized) \(i + 1)" : "\("Player".localized) \(i + 1)",
                isSpy: false,
                emoji: emoji
            ))
        }

//        for player in newPlayers {
//            editablePlayerNames.append(player.name)
//        }
        for _ in newPlayers {
            editablePlayerNames.append("")
        }

        spyIndices = Set<Int>()
        while spyIndices.count < spyCount {
            spyIndices.insert(Int.random(in: 0 ..< playerCount))
        }

        for index in spyIndices {
            newPlayers[index].isSpy = true
        }

        players = newPlayers
        gameState = .roleReveal
        currentPlayerIndex = customPlayerNames ? 0 : -1
    }

    private func getUniqueEmoji() -> String {
        var availableEmojis = Player.emojiOptions.filter { !usedEmojis.contains($0) }
        if availableEmojis.isEmpty {
            availableEmojis = Player.emojiOptions
        }

        let selectedEmoji = availableEmojis.randomElement()!
        usedEmojis.insert(selectedEmoji)
        return selectedEmoji
    }

    func updatePlayerNames() {
        for (index, _) in players.enumerated() {
            players[index].name = editablePlayerNames[index]
        }
    }

    func nextPlayer() {
        if hapticFeedback {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator.prepare()
            feedbackGenerator.impactOccurred()
        }

        currentPlayerIndex += 1
        if currentPlayerIndex >= players.count {
            startGame()
        }
    }

    func viewCurrentPlayerRole() {
        guard currentPlayerIndex >= 0 && currentPlayerIndex < players.count else { return }
        players[currentPlayerIndex].hasViewedRole = true
    }

    func startGame() {
        gameState = .playing
        startTimer()
    }

    func endGame(spyWins: Bool) {
        gameState = .finished
        timer?.cancel()
        timer = nil
        winnerRole = spyWins ? "SpiesWin".localized : "RegularPlayersWin".localized
    }

    func startTimer() {
        timer?.cancel()
        remainingSeconds = 8 * 60

        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.remainingSeconds > 0 {
                    if soundEffects && self.remainingSeconds == 11 {
                        AudioManager.shared.playSound("countDown")
                    }
                    self.remainingSeconds -= 1
                } else {
                    self.endGame(spyWins: true)
                }
            }
    }

    func backToGameSetup() {
        players = []
        editablePlayerNames = []
        gameState = .setup
        currentPlayerIndex = -1
        timer?.cancel()
        timer = nil
        remainingSeconds = 8 * 60
        currentCategoryItem = nil
        showingIntro = false
        customPlayerNames = false
        showSpiesToEachOther = false
    }

    func playAgain() {
        timer?.cancel()
        timer = nil
        remainingSeconds = 8 * 60
        currentCategoryItem = nil
        showingIntro = false

        currentCategoryItem = getCategoryItem()

        for i in players.indices {
            players[i].isSpy = false
        }

        var newPlayers = players
        spyIndices = Set<Int>()
        while spyIndices.count < spyCount {
            spyIndices.insert(Int.random(in: 0 ..< playerCount))
        }

        for index in spyIndices {
            newPlayers[index].isSpy = true
        }

        players = newPlayers
        gameState = .roleReveal
        currentPlayerIndex = -1
    }

    func getCategoryName() -> String {
        return currentCategoryItem?.name ?? "Unknown"
    }

    func getCategoryEmoji() -> String {
        return currentCategoryItem?.emoji ?? "School"
    }

    func getPlayerRoleDescription(_ player: Player) -> String {
        if player.isSpy {
            if spyCount > 1 && showSpiesToEachOther {
                var spyNames: [String] = []
                for index in spyIndices {
                    spyNames.append(players[index].name)
                }
                spyNames.removeAll { $0.contains(player.name) }
                var spiesText = "\("otherSpies".localized)"
                for (index, spyName) in spyNames.enumerated() {
                    if index > 0 {
                        spiesText += "  \("and".localized) \(spyName)"
                    } else {
                        spiesText += " \(spyName)"
                    }
                }
                switch gameType {
                case .location:
                    return "\("YouAreTheSpy".localized)\n\n\(spiesText)\n\n\(String(format: "FigureOutLocation".localized, "Location".localized))"
                case .animal:
                    return "\("YouAreTheSpy".localized)\n\n\(spiesText)\n\n\(String(format: "FigureOutLocation".localized, "Animal".localized))"
                case .kuwaitAreas:
                    return "\("YouAreTheSpy".localized)\n\n\(spiesText)\n\n\(String(format: "FigureOutLocation".localized, "Area".localized))"
                }
            } else {
                switch gameType {
                case .location:
                    return "\("YouAreTheSpy".localized)\n\n\(String(format: "FigureOutLocation".localized, "Location".localized))"
                case .animal:
                    return "\("YouAreTheSpy".localized)\n\n\(String(format: "FigureOutLocation".localized, "Animal".localized))"
                case .kuwaitAreas:
                    return "\("YouAreTheSpy".localized)\n\n\(String(format: "FigureOutLocation".localized, "Area".localized))"
                }
            }
        } else {
            switch gameType {
            case .location:
                return "\("Location".localized): \(currentCategoryItem?.name ?? "")\n\n\("PlayerRoleDescription".localized)"
            case .animal:
                return "\("Animal".localized): \(currentCategoryItem?.name ?? "")\n\n\("PlayerRoleDescription".localized)"
            case .kuwaitAreas:
                return "\("Area".localized): \(currentCategoryItem?.name ?? "")\n\n\("PlayerRoleDescription".localized)"
            }
        }
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
}
