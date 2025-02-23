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
    @State private var showTimer = true

    var formattedTime: String {
        let minutes = viewModel.remainingSeconds / 60
        let seconds = viewModel.remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Timer view
            VStack {
                if showTimer {
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.1), lineWidth: 8)

                        Circle()
                            .trim(from: 0, to: Double(viewModel.remainingSeconds) / (8 * 60))
                            .stroke(
                                viewModel.remainingSeconds < 60 ? Color.red :
                                    viewModel.remainingSeconds < 120 ? Color.orange : Color.blue,
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))

                        VStack(spacing: 4) {
                            Text(formattedTime)
                                .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)

                            Text("remaining")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .frame(width: 120, height: 120)
                    .padding(.vertical)
                }
            }
            .background(Color.black.opacity(0.3))
            .onTapGesture {
                withAnimation {
                    showTimer.toggle()
                }
            }

            ScrollView {
                VStack(spacing: 24) {
                    // Location list
                    VStack {
                        Button(action: {
                            withAnimation {
                                showLocationList.toggle()
                            }
                        }) {
                            HStack {
                                Text("Possible Locations")
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Spacer()

                                Image(systemName: showLocationList ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(16)
                        }

                        if showLocationList {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(Location.locations) { location in
                                    VStack(spacing: 8) {
                                        Text(location.emoji)
                                            .font(.system(size: 32))

                                        Text(location.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Question suggestions
                    VStack(alignment: .leading, spacing: 16) {
                        Text(NSLocalizedString("SuggestedQuestions", comment: "Suggested Questions"))
                            .font(.headline)
                            .foregroundColor(.white)

                        VStack(alignment: .leading, spacing: 12) {
                            QuestionSuggestion(
                                question: NSLocalizedString("SuggestedQuestion1", comment: "What can you see around you?"),
                                tip: NSLocalizedString("SuggestedTip1", comment: "Good opening question")
                            )

                            QuestionSuggestion(
                                question: "What sounds do you typically hear?",
                                tip: "Location atmosphere"
                            )

                            QuestionSuggestion(
                                question: "What activities happen here?",
                                tip: "Location purpose"
                            )

                            QuestionSuggestion(
                                question: "Who would you typically see here?",
                                tip: "Common visitors"
                            )

                            QuestionSuggestion(
                                question: "What time is this place busiest?",
                                tip: "Daily patterns"
                            )
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
            }

            // Action buttons
            VStack(spacing: 16) {
                PrimaryButton(text: NSLocalizedString("VoteOnSpy", comment: "Vote on Spy"), color: .red) {
                    viewModel.showVotingSheet = true
                }
                .padding(.horizontal)

                SecondaryButton(text: NSLocalizedString("EndGame", comment: "End Game"), color: .white) {
                    viewModel.endGame(spyWins: false)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(Color.black.opacity(0.3))
        }
        .sheet(isPresented: $viewModel.showVotingSheet) {
            VotingSheetView(viewModel: viewModel, isPresented: $viewModel.showVotingSheet)
        }
    }
}
