//
//  SecondaryButton.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//
import SwiftUI
import SwiftUICore

struct SecondaryButton: View {
    var text: String
    var color: Color = .blue
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(color)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(color.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        }
    }
}
