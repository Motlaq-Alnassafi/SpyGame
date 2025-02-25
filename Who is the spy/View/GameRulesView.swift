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
                        title: "Setup",
                        content: "1. Each player gets a secret card with a location.\n2. Most players get the same location, but the spy gets a different one.\n3. The spy doesn't know who the other players are, and the other players don't know who the spy is."
                    )

                    RuleSection(
                        title: "Gameplay",
                        content: "1. Players take turns asking one another questions about the location.\n2. The spy must pretend to know the location without being too obvious.\n3. Non-spy players must prove they know the location without revealing too much."
                    )

                    RuleSection(
                        title: "Winning",
                        content: "• The spy wins if they guess the correct location or if time runs out without being identified.\n• The non-spy players win if they correctly identify the spy."
                    )

                    RuleSection(
                        title: "Tips",
                        content: "• Ask questions that would be obvious to someone who knows the location.\n• Pay attention to hesitation or vague answers.\n• If you're the spy, listen carefully to gather clues about the location."
                    )
                }
                .padding()
            }
            .navigationBarTitle("Game Rules", displayMode: .inline)
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
