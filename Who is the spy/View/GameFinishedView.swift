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
        VStack(spacing: .zero) {
            VStack(spacing: 16) {
                Image(viewModel.winnerRole.contains("Spies") || viewModel.winnerRole.contains("الجواسيس") ? "SpiesWin" : "RegularPlayersWin")
                    .resizable()
                    .frame(width: 138, height: 100)

                Text(viewModel.winnerRole)
                    .font(.custom("Geist", size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(viewModel.getEndGameItemDescription())
                    .font(.custom("Geist", size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.white)

                HStack(spacing: 8) {
                    Image(viewModel.getCategoryEmoji())
                        .resizable()
                        .frame(width: 24, height: 24)

                    Text(viewModel.getCategoryName())
                        .font(.custom("Geist", size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Gradient(colors: [Color(hex: "#140600"), Color(hex: "#5C2500")]))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(hex: "#FF7519"), lineWidth: 1)
                )
                .cornerRadius(16)
                .padding(.bottom, -16)
            }
            .padding(.bottom, 32)

            VStack(alignment: .leading, spacing: 16) {
                Text("PlayerRoles".localized)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                ScrollView {
                    ForEach(viewModel.players) { player in
                        HStack(spacing: 12) {
                            Image(player.emoji)
                                .resizable()
                                .frame(width: 32, height: 32)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(player.name)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(player.isSpy ? "Spy".localized : "RegularPlayer".localized)
                                    .font(.subheadline)
                                    .foregroundColor(player.isSpy ? .red : .green)
                            }

                            Spacer()

                            Image(player.isSpy ? "spyList" : "Player")
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(CustomColors.innerBackground)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(hex: "#191919"), lineWidth: 1)
                                )
                        )
                        .cornerRadius(12)
                    }
                }
            }
            .padding()

            Spacer()

            VStack(spacing: 16) {
                PrimaryButton(text: "PlayAgain".localized, color: .indigo) {
                    viewModel.playAgain()
                }

                SecondaryButton(text: "ChangePlayers".localized, color: .white) {
                    viewModel.backToGameSetup()
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .padding(.top, 32)
    }
}
