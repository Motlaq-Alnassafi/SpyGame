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

    static let emojiOptions = ["30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41"]
}
