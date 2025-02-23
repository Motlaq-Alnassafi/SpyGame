//
//  Player.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import Foundation

struct Player: Identifiable {
    var id = UUID()
    var name: String
    var isSpy: Bool
    var hasViewedRole = false
    var emoji: String

    static let emojiOptions = ["😎", "🥸", "🧐", "🤠", "👻", "🤖", "👽", "🦊", "🐱", "🐶", "🦁", "🐯", "🐭", "🐹", "🐰"]
}
