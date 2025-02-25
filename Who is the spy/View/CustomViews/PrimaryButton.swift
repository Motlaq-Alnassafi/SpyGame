//
//  PrimaryButton.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI
import SwiftUICore

struct PrimaryButton: View {
    var text: String
    var color: Color = .init(hex: "#FF6600")
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(CustomColors.textColor)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(CustomColors.primaryButton)
                .cornerRadius(16)
                .shadow(color: Color.orange.opacity(0.2), radius: 10, x: 0, y: 5)
        }
    }
}
