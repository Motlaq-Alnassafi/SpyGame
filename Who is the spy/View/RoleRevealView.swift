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
    @State private var tapped = false
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 24) {
            CustomNavigationBarView(leftIcon: "house",
                                    leftAction: { showAlert = true }).alert("AreYouSure".localized, isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Yes".localized, role: .destructive) {
                    viewModel.showingIntro = true
                    viewModel.gameState = .setup
                }
            }
            .padding(.top, 20)
            .padding(.bottom, -24)

            if viewModel.currentPlayerIndex < 0 {
                VStack(spacing: 24) {
                    Text("🎭")
                        .font(.system(size: 64))
                        .padding(.top, 40)

                    Text("RoleReveal".localized)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("RoleRevealDiscription".localized)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 32)

                    Spacer()

                    PassPhoneAnimation()
                        .frame(height: 240)

                    Spacer()

                    PrimaryButton(text: "RoleRevealCTA".localized, color: .indigo) {
                        viewModel.nextPlayer()
                    }
                    .padding(.horizontal)
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
                        .padding(.horizontal)
                        .padding(.bottom, 32)
                        .disabled(viewModel.editablePlayerName.isEmpty)
                    }
                } else {
                    VStack(spacing: 24) {
                        Text("PassTheDevice".localized)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))

                        Text(player.name)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Spacer()

                        cardView(player: player)

                        Spacer()

                        if showRole {
                            PrimaryButton(text: "NextPlayer".localized) {
                                withAnimation {
                                    tapped = false
                                    showRole = false
                                    cardRotation = 0
                                    viewModel.nextPlayer()
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 32)
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    func cardView(player: Player) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#1A0A00"), Color(hex: "120600"), Color(hex: "#0A0400"), Color(hex: "#0A0400")]),

                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color(hex: "#FF7519"), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 10)
                .rotation3DEffect(
                    .degrees(cardRotation),
                    axis: (x: 0, y: 1, z: 0)
                )
                .overlay(
                    VStack(spacing: 16) {
                        if showRole {
                            Image(viewModel.getPlayerRoleEmoji(player))
                                .resizable()
                                .frame(width: viewModel.players[viewModel.currentPlayerIndex].isSpy ? 70 : 80, height: 80)

                            Text(viewModel.getPlayerRoleDescription(player))
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        } else {
                            Text("TapToRevealYourRole".localized)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top, 25)

                            Spacer()

                            Image("QuestionMark")
                                .resizable()
                                .frame(width: 80, height: 124, alignment: .bottom)
                                .padding(.bottom, 100)
                        }
                    }
                )
        }
        .frame(height: 400)
        .padding(.horizontal, 75)
        .onTapGesture {
            if !tapped {
                withAnimation(.easeInOut(duration: 0.4)) {
                    cardRotation += showRole == false ? 180 : 0
                    showRole = true
                    viewModel.viewCurrentPlayerRole()
                    tapped = true
                }
            }
        }
    }
}
