//
//  QuestionSuggestion.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI

struct QuestionSuggestion: View {
    var question: String
    var tip: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(question)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)

            Text(tip)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
    }
}
