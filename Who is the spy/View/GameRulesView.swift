//
//  GameRulesView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 25/02/2025.
//

import SwiftUI
import SwiftUICore

struct GameRulesView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("HowToPlay".localized)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)

                    RuleSection(
                        title: "Setup".localized,
                        content: "RuleSection1".localized
                    )

                    RuleSection(
                        title: "Gameplay".localized,
                        content: "RuleSection2".localized
                    )

                    RuleSection(
                        title: "Winning".localized,
                        content: "RuleSection3".localized
                    )

                    RuleSection(
                        title: "Tips".localized,
                        content: "RuleSection4".localized
                    )
                }
                .padding()
            }
            .navigationBarTitle("GameRules".localized, displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply")
                        .foregroundColor(CustomColors.primaryButton)
                        .frame(width: 32, height: 32)
                }
            )
        }
    }
}

struct RuleSection: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
        .padding(.bottom, 8)
    }
}
