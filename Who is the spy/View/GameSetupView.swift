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

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Text("🕵️")
                    .font(.system(size: 48))

                Text("GameSetup".localized)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding(.top, 32)

            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("\("Players".localized): \(playerCount)")
                            .font(.headline)
                            .foregroundColor(.white)

                        Spacer()

                        HStack(spacing: 4) {
                            ForEach(1 ... min(playerCount, 8), id: \.self) { _ in
                                Circle()
                                    .fill(Color.indigo)
                                    .frame(width: 8, height: 8)
                            }

                            if playerCount > 8 {
                                Text("+\(playerCount - 8)")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                    }

                    Slider(value: Binding(
                        get: { Double(playerCount) },
                        set: { playerCount = Int($0) }
                    ), in: 3 ... 12, step: 1)
                }

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("\("Spies".localized): \(spyCount)")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()

                        HStack(spacing: 4) {
                            ForEach(1 ... spyCount, id: \.self) { _ in
                                Image(systemName: "eye.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }

                    Slider(value: Binding(
                        get: { Double(spyCount) },
                        set: { spyCount = min(Int($0), playerCount - 2) }
                    ), in: 1 ... 4, step: 1)
                }
            }
            .padding(.horizontal)

            VStack(spacing: 16) {
                Toggle("CustomPlayerNames".localized, isOn: $viewModel.customPlayerNames)
                    .toggleStyle(SwitchToggleStyle(tint: .indigo))

                HStack {
                    Toggle("HapticFeedback".localized, isOn: $viewModel.hapticFeedback)
                        .toggleStyle(SwitchToggleStyle(tint: .indigo))

                    Spacer()

                    Toggle("SoundEffects".localized, isOn: $viewModel.soundEffects)
                        .toggleStyle(SwitchToggleStyle(tint: .indigo))
                }
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(16)
            .padding(.horizontal)

            Spacer()

            VStack(alignment: .leading, spacing: 8) {
                Text("HowToPlay".localized)
                    .font(.headline)
                    .foregroundColor(.white)

                Text("HowToPlayDescription".localized)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(16)
            .padding(.horizontal)

            PrimaryButton(text: "StartGame".localized, color: .indigo) {
                viewModel.playerCount = playerCount
                viewModel.spyCount = spyCount
                viewModel.setupGame(playerCount: playerCount, spyCount: spyCount)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
    }
}
