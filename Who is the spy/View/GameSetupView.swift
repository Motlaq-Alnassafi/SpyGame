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
            customNavigationBar()
                .padding(.top, 20)

            LogoCardView(title: "GameSetup".localized, logoFrame: 80, logoPadding: 10, frameHeight: 170, frameWidth: 200)
                .padding(.top, 32)

            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Text("\("Players".localized)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)

                        Spacer()

                        Text("\(playerCount)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }

                    CustomSlider(value: $playerCount, minimumValue: 3, maximumValue: 12)
                }

                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Text("\("Spies".localized)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)

                        Spacer()

                        Text("\(spyCount)")
                            .font(.system(size: 16, weight: .bold))
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

            PrimaryButton(text: "StartGame".localized, color: .indigo) {
                viewModel.playerCount = playerCount
                viewModel.spyCount = spyCount
                viewModel.setupGame(playerCount: playerCount, spyCount: spyCount)
            }
            .frame(alignment: .bottom)
            .padding(.horizontal, 48)
            .padding(.bottom, 32)
        }
        .fullScreenCover(isPresented: $showingRules) {
            GameRulesView()
        }
    }

    @ViewBuilder
    func customNavigationBar() -> some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                makeNavigationSectionButton(icon: "house", action: { viewModel.showingIntro = true })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                makeNavigationSectionButton(icon: "questionmark".localized, action: { showingRules = true })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 30)
            }
        }
    }

    @ViewBuilder
    func makeNavigationSectionButton(icon: String, action: @escaping (() -> Void)) -> some View {
        Button(action: action) {
            Image(systemName: icon)
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
