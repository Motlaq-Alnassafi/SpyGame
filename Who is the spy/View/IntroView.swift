//
//  IntroView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUICore
import UIKit
import SwiftUI

struct IntroView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 36) {
            Spacer()
            
            makeGlobeButton()
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.bottom, .top], -36)
                .padding(.leading, 20)

            VStack(spacing: 16) {
                Text("🕵️")
                    .font(.system(size: 80))

                Text("whoIsTheSpy".localized)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text("GameDescribtion".localized)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            VStack(spacing: 20) {
                FeatureRow(icon: "person.3.fill",
                           title: "GroupPlay".localized,
                           description: "GroupPlayDescription".localized)
                FeatureRow(icon: "map.fill",
                           title: "SecretLocations".localized,
                           description: "uniqueLocations".localized)
                FeatureRow(icon: "timer",
                           title: "TimedRounds".localized,
                           description: "TimedRoundsDescribtion".localized)
            }
            .padding(.horizontal)

            Spacer()

            PrimaryButton(text: "StartPlaying".localized, color: .indigo) {
                viewModel.showingIntro = false
            }
            .padding(.horizontal, 32)

            Spacer()
        }
    }
    
    @ViewBuilder
    func makeGlobeButton() -> some View {
        Button(action: {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(appSettings) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }
        }) {
            Image(systemName: "globe")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }
    }
}
