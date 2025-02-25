//
//  FeatureRow.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUICore

struct FeatureRow: View {
    var icon: String
    var title: String
    var description: String

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(CustomColors.mostInnerBackground)
                    .frame(width: 50, height: 50)

                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.system(size: 24))
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(CustomColors.textColor)

                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(CustomColors.descriptionColor)
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(CustomColors.innerBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
        )
        .padding(.horizontal)
    }
}
