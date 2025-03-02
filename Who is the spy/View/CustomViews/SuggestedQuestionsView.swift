//
//  SuggestedQuestionsView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI

struct SuggestedQuestionsView: View {
    @State private var currentIndex = 0

    let questions = [
        ("SuggestedQuestion1".localized, "eye"),
        ("SuggestedQuestion2".localized, "ear"),
        ("SuggestedQuestion3".localized, "activities"),
        ("SuggestedQuestion4".localized, "groupOfPeople"),
        ("SuggestedQuestion5".localized, "BusiestTime"),
    ]

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

            VStack(alignment: .leading, spacing: 12) {
                SuggestedQuestionCard(question: questions[currentIndex].0, icon: questions[currentIndex].1)

                HStack {
                    Button(action: {
                        if currentIndex > 0 { currentIndex -= 1 }
                    }) {
                        Image(systemName: "chevron.left".localized)
                            .foregroundColor(currentIndex == 0 ? .gray : .white)
                            .padding(10)
                    }
                    .disabled(currentIndex == 0)

                    Spacer()

                    PageIndicator(currentIndex: currentIndex, totalPages: questions.count)

                    Spacer()

                    Button(action: {
                        if currentIndex < questions.count - 1 { currentIndex += 1 }
                    }) {
                        Image(systemName: "chevron.right".localized)
                            .foregroundColor(currentIndex == questions.count - 1 ? .gray : .white)
                            .padding(10)
                    }
                    .disabled(currentIndex == questions.count - 1)
                }
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
        Text("SuggestedQuestions".localized)
            .foregroundColor(.white.opacity(0.6))
            .font(.system(size: 16))

        Text(question)
            .lineLimit(2)
            .foregroundColor(.white)
            .font(.system(size: 28))

        Spacer()

        Image(icon)
            .resizable()
            .frame(width: 80, height: 62)
            .foregroundColor(.clear)
            .padding(.leading, 10)

        Spacer()
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
