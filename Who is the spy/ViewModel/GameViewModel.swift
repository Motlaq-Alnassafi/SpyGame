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
    @Published var winnerRole: String = ""
    @Published var showingIntro = true
    @Published var editablePlayerNames: [String] = []
    @Published var playerCount = 0
    @Published var spyCount = 0
    @Published var category: [CategoryItem] = CategoryItem.generalLocations
    @Published var timerManager = GameTimerManager()
    //    @Published var showVotingSheet = false
    var settingsManager = SettingsManager()
    var currentCategoryItem: CategoryItem?
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
            newPlayers.append(Player(
                name: settingsManager.customPlayerNames ? "\("Player".localized) \(i + 1)" : "\("Player".localized) \(i + 1)",
                isSpy: false,
                emoji: getUniqueEmoji()
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
        currentPlayerIndex = settingsManager.customPlayerNames ? 0 : -1
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
        settingsManager.triggerHapticFeedback(style: .heavy)

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
        timerManager.startTimer { [weak self] in
            self?.endGame(spyWins: true)
        }
    }

    func endGame(spyWins: Bool) {
        gameState = .finished
        timerManager.stopTimer()
        winnerRole = spyWins ? "SpiesWin".localized : "RegularPlayersWin".localized
    }

    func backToGameSetup() {
        players = []
        editablePlayerNames = []
        gameState = .setup
        currentPlayerIndex = -1
        timerManager.stopTimer()
        currentCategoryItem = nil
        showingIntro = false
        settingsManager.customPlayerNames = false
        settingsManager.showSpiesToEachOther = false
    }

    func playAgain() {
        timerManager.stopTimer()
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
}
