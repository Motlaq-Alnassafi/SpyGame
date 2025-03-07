//
//  GamePlayView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI
import SwiftUICore

struct GamePlayView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var showLocationList = false
    @State private var showAlert = false
    @State private var displayedTime: String = ""

    var formattedTime: String {
        let minutes = viewModel.timerManager.remainingSeconds / 60
        let seconds = viewModel.timerManager.remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            VStack {
//                Spacer()

                ZStack {
                    Circle()
                        .fill(CustomColors.innerBackground)
                        .frame(height: 176)

                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.1), lineWidth: 4)

                        Circle()
                            .trim(from: 0, to: Double(viewModel.timerManager.remainingSeconds) / (8 * 60))
                            .stroke(Color(hex: "#FF6600"),
                                    style: StrokeStyle(lineWidth: 4, lineCap: .round))
                            .rotationEffect(.degrees(-90))

                        VStack(spacing: 4) {
                            Text("remaining".localized)
                                .font(.custom("Geist", size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(.white.opacity(0.7))
                            Text(displayedTime)
                                .font(.custom("Geist", size: 48))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .onReceive(viewModel.timerManager.$remainingSeconds) { _ in
                                    self.displayedTime = formattedTime
                                }
                        }
                    }
                    .frame(width: 176, height: 176)
                    .padding(.vertical)
                }
                .frame(width: 176, height: 176)
            }

//            Spacer()

            SuggestedQuestionsView(viewModel: viewModel)

            Spacer()

            VStack(spacing: 16) {
//                PrimaryButton(text: "VoteOnSpy".localized) {
//                    viewModel.showVotingSheet = true
//                }

                PrimaryButton(text: "EndGame".localized) {
                    showAlert = true
                }.alert("WhoWon".localized, isPresented: $showAlert) {
                    Button("Players", role: .cancel) {
                        viewModel.endGame(spyWins: false)
                    }
                    Button("Spies".localized, role: .destructive) {
                        viewModel.endGame(spyWins: true)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
//        .sheet(isPresented: $viewModel.showVotingSheet) {
//            VotingSheetView(viewModel: viewModel, isPresented: $viewModel.showVotingSheet)
//        }
    }
}
