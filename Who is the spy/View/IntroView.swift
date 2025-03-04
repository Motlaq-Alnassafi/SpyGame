//
//  IntroView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI
import SwiftUICore
import UIKit

struct IntroView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: .zero) {
            makeGlobeButton()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 20)
                .padding(.bottom, 20)

            LogoCardView(title: "whoIsTheSpy".localized, description: "GameDescribtion".localized, logoHeight: 138, logoWidth: 184, logoPadding: 0, frameHeight: 260, frameWidth: 248)
                .padding(.bottom, 36)

            VStack(spacing: 20) {
                FeatureRow(icon: "GroupPlay",
                           title: "GroupPlay".localized,
                           description: "GroupPlayDescription".localized)
                FeatureRow(icon: "SecretLocations",
                           title: "SecretLocations".localized,
                           description: "uniqueLocations".localized)
                FeatureRow(icon: "TimeRounds",
                           title: "TimedRounds".localized,
                           description: "TimedRoundsDescribtion".localized)
            }
            .padding(.horizontal)

            Spacer()

            PrimaryButton(text: "StartPlaying".localized, color: .indigo) {
                viewModel.showingIntro = false
                viewModel.gameState = .gameType
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
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
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 9)
                        .fill(CustomColors.innerBackground)
                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
        }
    }
}
