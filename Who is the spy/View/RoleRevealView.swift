//
//  RoleRevealView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI
import SwiftUICore

struct RoleRevealView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var showRole = false
    @State private var cardRotation = 0.0

    var body: some View {
        VStack(spacing: 24) {
            if viewModel.currentPlayerIndex < 0 {
                VStack(spacing: 24) {
                    Text("🎭")
                        .font(.system(size: 64))
                        .padding(.top, 40)

                    Text(NSLocalizedString("RoleReveal", comment: "Time to Reveal Roles"))
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text(NSLocalizedString("RoleRevealDiscription", comment: "Pass the device around so each player can see their secret role. Don't show your role to others!"))
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 32)

                    Spacer()

                    PassPhoneAnimation()
                        .frame(height: 240)

                    Spacer()

                    PrimaryButton(text: NSLocalizedString("RoleRevealCTA", comment: "Begin Role Reveal"), color: .indigo) {
                        viewModel.nextPlayer()
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                }
            } else if viewModel.currentPlayerIndex < viewModel.players.count {
                let player = viewModel.players[viewModel.currentPlayerIndex]

                if viewModel.customPlayerNames && !showRole {
                    VStack(spacing: 32) {
                        Text("👤")
                            .font(.system(size: 64))
                            .padding(.top, 40)

                        Text("Who Are You?")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        TextField("Enter your name", text: $viewModel.editablePlayerName)
                            .font(.title3)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)

                        Spacer()

                        PrimaryButton(text: "Continue", color: .indigo) {
                            viewModel.updatePlayerName(newName: viewModel.editablePlayerName)
                            showRole = true
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 32)
                        .disabled(viewModel.editablePlayerName.isEmpty)
                    }
                } else {
                    VStack(spacing: 24) {
                        Text(NSLocalizedString("PassTheDevice", comment: "Pass the device to"))
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))

                        Text(player.name)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

//                                                Text(player.emoji)
//                                                    .font(.system(size: 64))

                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [viewModel.getRoleColor(player).opacity(0.6), viewModel.getRoleColor(player).opacity(0.8)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.2), radius: 10)
                                .rotation3DEffect(
                                    .degrees(cardRotation),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .overlay(
                                    VStack(spacing: 16) {
                                        if showRole {
                                            Text(viewModel.getPlayerRoleEmoji(player))
                                                .font(.system(size: 48))

                                            Text(viewModel.getPlayerRoleDescription(player))
                                                .font(.headline)
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                                .padding(.horizontal)
                                        } else {
                                            Text(NSLocalizedString("TapToRevealYourRole", comment: "Tap to reveal your role"))
                                                .font(.headline)
                                                .foregroundColor(.white)
                                        }
                                    }
                                )
                        }
                        .frame(height: 280)
                        .padding(.horizontal, 32)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                cardRotation += showRole == false ? 180 : 0
                                showRole = true
                                viewModel.viewCurrentPlayerRole()
                            }
                        }

                        Spacer()

                        if showRole {
                            PrimaryButton(text: NSLocalizedString("NextPlayer", comment: "Next Player"), color: viewModel.getRoleColor(player)) {
                                withAnimation {
                                    showRole = false
                                    cardRotation = 0
                                    viewModel.nextPlayer()
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.bottom, 32)
                        }
                    }
                }
            }
        }
    }
}
