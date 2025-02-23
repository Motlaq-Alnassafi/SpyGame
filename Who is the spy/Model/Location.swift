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
        Location(name: NSLocalizedString("Synagogue", comment: "Synagogue"), emoji: "🕍", color: .gray),
        Location(name: NSLocalizedString("KuwaitTowers", comment: "Kuwait Towers"), emoji: "🗼", color: .gray),
        Location(name: NSLocalizedString("Mosque", comment: "Mosque"), emoji: "🕋", color: .gray),
        Location(name: NSLocalizedString("TheWalk", comment: "The walk"), emoji: "💰", color: .gray),
        Location(name: NSLocalizedString("JaberBridge", comment: "Jaber bridge"), emoji: "🌉", color: .gray),
        Location(name: NSLocalizedString("Chalat", comment: "Chalat"), emoji: "🌊", color: .gray),
        Location(name: NSLocalizedString("NationalAssembly", comment: "National Assembly"), emoji: "🏬", color: .gray),
        Location(name: NSLocalizedString("TheMoon", comment: "The Moon"), emoji: "🌑", color: .gray),
        Location(name: NSLocalizedString("Camping", comment: "Camping"), emoji: "🏜️", color: .gray),
        Location(name: NSLocalizedString("HellFire", comment: "Hell Fire"), emoji: "👹", color: .gray),
        Location(name: NSLocalizedString("Haven", comment: "Haven"), emoji: "😇", color: .gray),
        Location(name: NSLocalizedString("LuandryMat", comment: "Luandry Mat"), emoji: "👔", color: .gray),
        Location(name: NSLocalizedString("Farm", comment: "Farm"), emoji: "👨🏻‍🌾", color: .gray),
        Location(name: NSLocalizedString("CarDealerShip", comment: "Car Dealer Ship"), emoji: "🚘", color: .gray),
        Location(name: NSLocalizedString("BarbarShop", comment: "Barbar Shop"), emoji: "💈", color: .gray),
        Location(name: NSLocalizedString("SuperMarket", comment: "Super Market"), emoji: "🏪", color: .gray),
        Location(name: NSLocalizedString("JACC", comment: "Jaber Al-Ahmad Cultural Center"), emoji: "🏪", color: .gray),
    ]
}
