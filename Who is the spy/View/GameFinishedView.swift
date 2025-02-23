//
//  GameFinishedView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI
import SwiftUICore

struct GameFinishedView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text(viewModel.winnerRole.contains("Spies") ? "🕵️" : "👥")
                    .font(.system(size: 64))

                Text(viewModel.winnerRole)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text(NSLocalizedString("TheLocationWas", comment: "The location was"))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))

                HStack(spacing: 8) {
                    Text(viewModel.getLocationEmoji())
                        .font(.system(size: 24))

                    Text(viewModel.getLocationName())
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(16)
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Player Roles")
                        .font(.headline)
                        .foregroundColor(.white)

                    ForEach(viewModel.players) { player in
                        HStack(spacing: 12) {
                            Text(player.emoji)
                                .font(.system(size: 24))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(player.name)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(player.isSpy ? NSLocalizedString("Spy", comment: "Spy") : NSLocalizedString("RegularPlayer", comment: "Regular Player"))
                                    .font(.subheadline)
                                    .foregroundColor(player.isSpy ? .red : .green)
                            }

                            Spacer()

                            Image(systemName: player.isSpy ? "eye.fill" : "person.fill")
                                .foregroundColor(player.isSpy ? .red : .green)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }

            Spacer()

            VStack(spacing: 16) {
                PrimaryButton(text: NSLocalizedString("PlayAgain", comment: "Play Again"), color: .indigo) {
                    viewModel.resetGame()
                }

                SecondaryButton(text: NSLocalizedString("ChangePlayers", comment: "Change Players"), color: .white) {
                    viewModel.resetGame()
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
        .padding(.top, 32)
    }
}
