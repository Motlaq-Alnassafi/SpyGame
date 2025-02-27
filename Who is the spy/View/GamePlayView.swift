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

    var formattedTime: String {
        let minutes = viewModel.remainingSeconds / 60
        let seconds = viewModel.remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack(spacing: 16) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
//                            .fill(Gradient(colors: [Color(hex: "#131313"), Color(hex: "#0C321C")]))
                        .fill(CustomColors.innerBackground)
                        .frame(height: 290)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.green.opacity(0.2), lineWidth: 1)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.1), lineWidth: 4)

                        Circle()
                            .trim(from: 0, to: Double(viewModel.remainingSeconds) / (8 * 60))
//                                .stroke(Color(hex: "#0CF25D"),
                            .stroke(Color(hex: "#FF6600"),
                                    style: StrokeStyle(lineWidth: 4, lineCap: .round))
                            .rotationEffect(.degrees(-90))

                        VStack(spacing: 4) {
                            Text("remaining".localized)
                                .font(.system(size: 16, weight: .medium, design: .serif))
                                .foregroundColor(.white.opacity(0.7))
                            Text(formattedTime)
                                .font(.system(size: 48, weight: .medium, design: .serif))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 176, height: 176)
                    .padding(.vertical)
                }
                .frame(width: 290, height: 290)
            }

            ScrollView {
                SuggestedQuestionsView()
            }

            VStack(spacing: 16) {
                PrimaryButton(text: "VoteOnSpy".localized, color: .red) {
                    viewModel.showVotingSheet = true
                }
                .padding(.horizontal)

                SecondaryButton(text: "EndGame".localized, color: .white) {
                    viewModel.endGame(spyWins: false)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .sheet(isPresented: $viewModel.showVotingSheet) {
            VotingSheetView(viewModel: viewModel, isPresented: $viewModel.showVotingSheet)
        }
    }
}
