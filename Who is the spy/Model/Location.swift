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

    static var locations = [
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
        Location(name: "SouqAl-Mubarakiya".localized, emoji: "🛍️", color: .gray),
        Location(name: "GrandMosque".localized, emoji: "🕌", color: .gray),
        Location(name: "AlShaheedPark".localized, emoji: "🌳", color: .gray),
        Location(name: "SouqSharq".localized, emoji: "🛒", color: .gray),
        Location(name: "TheScientificCenter".localized, emoji: "🔬", color: .gray),
        Location(name: "KuwaitZoo".localized, emoji: "🦁", color: .gray),
        Location(name: "EntertainmentCity".localized, emoji: "🎢", color: .gray),
        Location(name: "SeifPalace".localized, emoji: "🏰", color: .gray),
        Location(name: "TheAvenues".localized, emoji: "🛒", color: .gray),
        Location(name: "SabahAlAhmadNatureReserve".localized, emoji: "🌿", color: .gray),
        Location(name: "FridayMarket".localized, emoji: "🎪", color: .gray),
        Location(name: "LiberationTower".localized, emoji: "📡", color: .gray),
        Location(name: "KuwaitEquestrianClub".localized, emoji: "🐎", color: .gray),
        Location(name: "KuwaitNationalLibrary".localized, emoji: "📚", color: .gray),
        Location(name: "FailakaIsland".localized, emoji: "⛵", color: .gray),
        Location(name: "AlRayaMall".localized, emoji: "🛍️", color: .gray),
        Location(name: "KhiranResort".localized, emoji: "🏖️", color: .gray),
        Location(name: "360Mall".localized, emoji: "🏢", color: .gray),
        Location(name: "QadsiaSportsClub".localized, emoji: "🏆", color: .gray),
        Location(name: "AlKoutMall".localized, emoji: "🏬", color: .gray),
        Location(name: "FishMarket".localized, emoji: "🐟", color: .gray),
        Location(name: "MuroojComplex".localized, emoji: "🍽️", color: .gray),
        Location(name: "IceSkatingRink".localized, emoji: "⛸️", color: .gray),
        Location(name: "KuwaitOperaHouse".localized, emoji: "🎶", color: .gray),
        Location(name: "KuwaitInternationalAirport".localized, emoji: "✈️", color: .gray),
        Location(name: "JaberInternationalStadium".localized, emoji: "🏟️", color: .gray),
        Location(name: "ShuwaikhIndustrialArea".localized, emoji: "🏭", color: .gray),
        Location(name: "KuwaitUniversity".localized, emoji: "🎓", color: .gray),
    ].shuffled()
}
