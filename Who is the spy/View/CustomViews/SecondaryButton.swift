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
                .font(.custom("Geist", size: 20))
                .fontWeight(.bold)
                .foregroundColor(color)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "#FF6600").opacity(0.10), Color(hex: "#AE1C00").opacity(0.10), Color(hex: "#AE1C00").opacity(0.10)]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(hex: "#FF6600"), lineWidth: 1)
                )
        }
    }
}
