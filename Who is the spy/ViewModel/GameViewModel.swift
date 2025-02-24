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
    @Published var currentPlayerIndex: Int = -1
    @Published var timer: AnyCancellable?
    @Published var remainingSeconds: Int = 8 * 60 // 8 minutes
    @Published var winnerRole: String = ""
    @Published var showVotingSheet = false
    @Published var showingIntro = true
    @Published var hapticFeedback = true
    @Published var soundEffects = true
    @Published var customPlayerNames = false
    @Published var editablePlayerName = ""
    @Published var playerCount = 0
    @Published var spyCount = 0
    @Published var emoji = ""

    private var locations = Location.locations
    private var currentLocation: Location?
    private var usedEmojis = Set<String>()
    private var currentIndex = 0

    enum GameState {
        case setup
        case roleReveal
        case playing
        case finished
    }

    func getLocation() -> Location? {
        guard currentIndex < locations.count else {
            locations.shuffle()
            currentIndex = 0
            return returnLocation()
        }
        return returnLocation()
    }
    
    func returnLocation() -> Location {
        let location = locations[currentIndex]
        currentIndex += 1
        return location
    }

    func setupGame(playerCount: Int, spyCount: Int) {
        guard playerCount >= 3 && spyCount >= 1 && spyCount < playerCount else { return }
        currentLocation = getLocation()
        usedEmojis.removeAll()

        var newPlayers: [Player] = []
        for i in 0 ..< playerCount {
            let emoji = getUniqueEmoji()
            newPlayers.append(Player(
                name: customPlayerNames ? "\("Player".localized) \(i + 1)" : "\("Player".localized) \(i + 1)",
                isSpy: false,
                emoji: emoji
            ))
        }

        var spyIndices = Set<Int>()
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

    private func getUniqueEmoji() -> String {
        var availableEmojis = Player.emojiOptions.filter { !usedEmojis.contains($0) }
        if availableEmojis.isEmpty {
            availableEmojis = Player.emojiOptions
        }

        let selectedEmoji = availableEmojis.randomElement()!
        usedEmojis.insert(selectedEmoji)
        return selectedEmoji
    }

    func updatePlayerName(newName: String) {
        guard currentPlayerIndex >= 0 && currentPlayerIndex < players.count else { return }
        players[currentPlayerIndex].name = newName
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
        } else if customPlayerNames {
            editablePlayerName = "Player \(currentPlayerIndex + 1)"
        }
    }

    func viewCurrentPlayerRole() {
        guard currentPlayerIndex >= 0 && currentPlayerIndex < players.count else { return }
        emoji = ""
        players[currentPlayerIndex].hasViewedRole = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {[weak self] in
            guard let self = self else { return }
            emoji = getPlayerRoleEmoji(players[currentPlayerIndex])
        }
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
                    self.remainingSeconds -= 1
                } else {
                    self.endGame(spyWins: true)
                }
            }
    }

    func resetGame() {
        players = []
        gameState = .setup
        currentPlayerIndex = -1
        timer?.cancel()
        timer = nil
        remainingSeconds = 8 * 60
        currentLocation = nil
        showingIntro = false
    }
    
    func playAgain() {
        timer?.cancel()
        timer = nil
        remainingSeconds = 8 * 60
        currentLocation = nil
        showingIntro = false
        setupGame(playerCount: playerCount, spyCount: spyCount)
    }

    func getLocationName() -> String {
        return currentLocation?.name ?? "Unknown"
    }

    func getLocationEmoji() -> String {
        return currentLocation?.emoji ?? "🏠"
    }

    func getLocationColor() -> Color {
        return currentLocation?.color ?? .blue
    }

    func getPlayerRoleDescription(_ player: Player) -> String {
        if player.isSpy {
            return "\("YouAreTheSpy".localized)\n\n\("FigureOutLocation".localized)"
        } else {
            return "\("Location".localized): \(currentLocation?.name ?? "")\n\n\("PlayerRoleDescription".localized)"
        }
    }

    func getPlayerRoleEmoji(_ player: Player) -> String {
        if player.isSpy {
            return "🕵️"
        } else {
            return currentLocation?.emoji ?? "🏠"
        }
    }

    func getRoleColor(_ player: Player) -> Color {
        if player.isSpy {
            return .gray
        } else {
            return currentLocation?.color ?? .blue
        }
    }
}
