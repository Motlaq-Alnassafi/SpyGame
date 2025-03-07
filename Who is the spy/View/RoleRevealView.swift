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
                                    leftAction: {
                                        showAlert = true
                                    }).alert("AreYouSure".localized, isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Yes".localized, role: .destructive) {
                    viewModel.showingIntro = true
                    viewModel.settingsManager.customPlayerNames = false
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
                        .font(.custom("Geist", size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("RoleRevealDiscription".localized)
                        .font(.custom("Geist", size: 16))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 32)

                    Spacer()

                    PassPhoneAnimation()
                        .frame(height: 240)

                    Spacer()

                    PrimaryButton(text: "RoleRevealCTA".localized) {
                        viewModel.nextPlayer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
            } else if viewModel.currentPlayerIndex < viewModel.players.count {
                let player = viewModel.players[viewModel.currentPlayerIndex]

                if viewModel.settingsManager.customPlayerNames && !showRole {
                    customNameView(viewModel: viewModel)
                } else {
                    VStack(spacing: 20) {
                        Text("PassTheDevice".localized)
                            .font(.custom("Geist", size: 28))
                            .fontWeight(.regular)
                            .foregroundColor(.white.opacity(0.8))

                        Text(player.name)
                            .font(.custom("Geist", size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Spacer()

                        cardView(player: player)

                        Spacer()

                        if showRole {
                            PrimaryButton(text: "NextPlayer".localized) {
                                withAnimation(.easeInOut(duration: viewModel.settingsManager.customPlayerNames == true ? 0 : 0.3)) {
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
    func customNameView(viewModel: GameViewModel) -> some View {
        VStack(spacing: .zero) {
            Image("CustomName")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.top, 32)

            Text("CustomPlayerNamesEntry".localized)
                .font(.custom("Geist", size: 28))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 24)
            ScrollView {
                ForEach(viewModel.players.indices, id: \.self) { Index in
                    VStack(alignment: .leading, spacing: 4) {
                        let playerName = "Player".localized + " \(Index + 1)"
                        Text(playerName)
                        TextField("Enter your name".localized, text: $viewModel.editablePlayerNames[Index])
                            .padding(8)
                            .font(.custom("Geist", size: 20))
                            .multilineTextAlignment(.leading)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(CustomColors.innerBackground)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white.opacity(0.15), lineWidth: 1)
                                    )
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top, 24)

            Spacer()

            Button(action: {
                viewModel.updatePlayerNames()
                viewModel.currentPlayerIndex = -1
                viewModel.settingsManager.customPlayerNames = false
            }) {
                Text("Continue".localized)
                    .font(.custom("Geist", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.editablePlayerNames.contains { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } ? CustomColors.textColor.opacity(0.15) : CustomColors.textColor)
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .background(viewModel.editablePlayerNames.contains { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } ? CustomColors.primaryButton.opacity(0.15) : CustomColors.primaryButton)
                    .cornerRadius(16)
                    .shadow(color: Color.orange.opacity(0.2), radius: 10, x: 0, y: 5)
            }
            .disabled(viewModel.editablePlayerNames.contains { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } ? true : false)
            .frame(alignment: .bottom)
            .padding(.horizontal)
            .padding(.bottom, 32)
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
                                .font(.custom("Geist", size: 20))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        } else {
                            Text("TapToRevealYourRole".localized)
                                .font(.custom("Geist", size: 20))
                                .fontWeight(.medium)
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
                withAnimation(.easeInOut(duration: 0.3)) {
                    cardRotation += showRole == false ? 180 : 0
                    showRole = true
                    viewModel.viewCurrentPlayerRole()
                    tapped = true
                }
            }
        }
    }
}
