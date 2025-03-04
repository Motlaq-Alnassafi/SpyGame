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

                Image(icon)
                    .foregroundColor(.white)
                    .font(.system(size: 24))
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.custom("Geist", size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(CustomColors.textColor)

                Text(description)
                    .font(.custom("Geist", size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(CustomColors.textColor)
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
    }
}
