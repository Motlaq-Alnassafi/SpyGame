//
//  GameSetupView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI
import SwiftUICore

struct GameSetupView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var playerCount: Int = 5
    @State private var spyCount: Int = 1
    @State private var showingRules = false

    var body: some View {
        VStack(spacing: .zero) {
            CustomNavigationBarView(leftIcon: "house",
                                    rightIcon: "questionmark".localized,
                                    leftAction: { viewModel.showingIntro = true },
                                    rightAction: { showingRules = true })
                .padding(.top, 20)

            LogoCardView(title: "GameSetup".localized,
                         logoHeight: 138,
                         logoWidth: 184,
                         logoPadding: 0,
                         frameHeight: 190,
                         frameWidth: 200)
                .padding(.top, 32)

            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: .zero) {
                        Image("PlayerSettingPage")
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("\("Players".localized)")
                            .font(.custom("Geist", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Spacer()

                        Text("\(playerCount)")
                            .font(.custom("Geist", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }

                    CustomSlider(value: $playerCount, minimumValue: 3, maximumValue: 12)
                }

                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Image("SpySettingPage")
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("\("Spies".localized)")
                            .font(.custom("Geist", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Spacer()

                        Text("\(spyCount)")
                            .font(.custom("Geist", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }

                    CustomSlider(value: $spyCount, minimumValue: 1, maximumValue: 4)
                }
            }
            .padding(.horizontal)

            CustomToggle(toggled: $viewModel.customPlayerNames, text: "CustomPlayerNames".localized)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding(.horizontal)

            SmallerToggleView(toggled: $viewModel.hapticFeedback, text: "HapticFeedback".localized)
                .padding(.horizontal)
                .padding(.bottom, 16)

            SmallerToggleView(toggled: $viewModel.soundEffects, text: "SoundEffects".localized)
                .padding(.horizontal)
                .padding(.bottom, 16)

            Spacer()

            Button(action: {
                viewModel.playerCount = playerCount
                viewModel.spyCount = spyCount
                viewModel.setupGame(playerCount: playerCount, spyCount: spyCount)
            }) {
                Text("StartGame".localized)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(spyCount < (playerCount + 1) / 2 ? CustomColors.textColor : CustomColors.textColor.opacity(0.15))
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .background(spyCount < (playerCount + 1) / 2 ? CustomColors.primaryButton : CustomColors.primaryButton.opacity(0.15))
                    .cornerRadius(16)
                    .shadow(color: Color.orange.opacity(0.2), radius: 10, x: 0, y: 5)
            }
            .disabled(spyCount < (playerCount + 1) / 2 ? false : true)
            .frame(alignment: .bottom)
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .fullScreenCover(isPresented: $showingRules) {
            GameRulesView()
        }
    }
}
