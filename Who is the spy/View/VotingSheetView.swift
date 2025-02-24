//
//  VotingSheetView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI
import SwiftUICore

struct VotingSheetView: View {
    @ObservedObject var viewModel: GameViewModel
    @Binding var isPresented: Bool
    @State private var selectedPlayer: Player?
    @State private var showConfirmation = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.9).ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("VoteOnSpy".localized)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("SelectSpy".localized)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))

                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.players) { player in
                                Button(action: {
                                    selectedPlayer = player
                                    showConfirmation = true
                                }) {
                                    VStack(spacing: 12) {
                                        Text(player.emoji)
                                            .font(.system(size: 40))

                                        Text(player.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        selectedPlayer?.id == player.id ?
                                            Color.red.opacity(0.3) :
                                            Color.white.opacity(0.1)
                                    )
                                    .cornerRadius(16)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarItems(trailing: Button("Cancel".localized) {
                isPresented = false
            })
        }
        .alert(isPresented: $showConfirmation) {
            Alert(
                title: Text("ConfirmVote".localized),
                message: Text("Are you sure \(selectedPlayer?.name ?? "") is a spy?"),
                primaryButton: .destructive(Text("Vote".localized)) {
                    isPresented = false
                    if let player = selectedPlayer {
                        viewModel.endGame(spyWins: !player.isSpy)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}
