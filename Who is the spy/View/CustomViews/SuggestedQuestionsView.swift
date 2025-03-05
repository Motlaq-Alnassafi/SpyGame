//
//  SuggestedQuestionsView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI

struct SuggestedQuestionsView: View {
    @State private var currentIndex = 0
    @ObservedObject var viewModel: GameViewModel

    var questions: [(String, String)]

    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        questions = viewModel.getSuggestedQuestions()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(CustomColors.innerBackground)
                .frame(height: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "#191919"), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)

            VStack {
                TabView(selection: $currentIndex) {
                    ForEach(0 ..< questions.count, id: \.self) { index in
                        SuggestedQuestionCard(question: questions[index].0, icon: questions[index].1)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                Spacer()

                PageIndicator(currentIndex: currentIndex, totalPages: questions.count)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 10)
            }
            .padding(20)
        }
        .frame(width: 380, height: 350)
    }
}

struct SuggestedQuestionCard: View {
    let question: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SuggestedQuestions".localized)
                .foregroundColor(.white.opacity(0.6))
                .font(.system(size: 16))
                .padding(.top, 10)

            Text(question)
                .lineLimit(2)
                .foregroundColor(.white)
                .font(.system(size: 28))

            Spacer()

            HStack {
                Spacer()
                Image(icon)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.clear)

                Spacer()
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 0)
    }
}

struct PageIndicator: View {
    let currentIndex: Int
    let totalPages: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0 ..< totalPages, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color(hex: "#FF6600") : Color.gray.opacity(0.4))
                    .frame(width: 8, height: 8)
            }
        }
    }
}
