//
//  Location.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUICore

struct Location: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var emoji: String
    var color: Color

    static let locations = [
        Location(name: "Synagogue".localized, emoji: "🕍", color: .gray),
        Location(name: "KuwaitTowers".localized, emoji: "🗼", color: .gray),
        Location(name: "Mosque".localized, emoji: "🕋", color: .gray),
        Location(name: "TheWalk".localized, emoji: "💰", color: .gray),
        Location(name: "JaberBridge".localized, emoji: "🌉", color: .gray),
        Location(name: "Chalat".localized, emoji: "🌊", color: .gray),
        Location(name: "NationalAssembly".localized, emoji: "🏬", color: .gray),
        Location(name: "TheMoon".localized, emoji: "🌑", color: .gray),
        Location(name: "Camping".localized, emoji: "🏜️", color: .gray),
        Location(name: "HellFire".localized, emoji: "👹", color: .gray),
        Location(name: "Haven".localized, emoji: "😇", color: .gray),
        Location(name: "LuandryMat".localized, emoji: "👔", color: .gray),
        Location(name: "Farm".localized, emoji: "👨🏻‍🌾", color: .gray),
        Location(name: "CarDealerShip".localized, emoji: "🚘", color: .gray),
        Location(name: "BarbarShop".localized, emoji: "💈", color: .gray),
        Location(name: "SuperMarket".localized, emoji: "🏪", color: .gray),
        Location(name: "JACC".localized, emoji: "🏪", color: .gray),
    ]
}
