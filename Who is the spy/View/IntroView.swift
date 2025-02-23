//
//  IntroView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUICore

struct IntroView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 36) {
            Spacer()

            VStack(spacing: 16) {
                Text("🕵️")
                    .font(.system(size: 80))

                Text(NSLocalizedString("whoIsTheSpy", comment: "Game Title"))
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text(NSLocalizedString("GameDescribtion", comment: "A social deduction game"))
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            VStack(spacing: 20) {
                FeatureRow(icon: "person.3.fill", title: NSLocalizedString("GroupPlay", comment: "Group Play"), description: NSLocalizedString("GroupPlayDescription", comment: "3-12 players try to find the spy"))
                FeatureRow(icon: "map.fill", title: NSLocalizedString("SecretLocations", comment: "Secret Locations"), description: NSLocalizedString("uniqueLocations", comment: "15 unique locations to discover"))
                FeatureRow(icon: "timer", title: NSLocalizedString("TimedRounds", comment: "Timed Rounds"), description: NSLocalizedString("TimedRoundsDescribtion", comment: "8-minute gameplay with countdown"))
            }
            .padding(.horizontal)

            Spacer()

            PrimaryButton(text: NSLocalizedString("StartPlaying", comment: "Start Playing"), color: .indigo) {
                viewModel.showingIntro = false
            }
            .padding(.horizontal, 32)

            Spacer()
        }
    }
}
