//
//  SmallerToggleView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 25/02/2025.
//

import SwiftUI

struct SmallerToggleView: View {
    @State private var isToggled: Bool = true
    @Binding var toggled: Bool
    var text: String
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 14))

            Spacer()

            Button(action: {
                toggled = isToggled == false ? false : true
                isToggled.toggle()
                toggled.toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(isToggled ? Color(hex: "#FF6600") : Color.gray.opacity(0.3))
                        .frame(width: 30, height: 20)

                    Circle()
                        .fill(Color.black)
                        .frame(width: 20, height: 20)
                        .offset(x: isToggled ? 10 : -10)
                        .animation(.easeInOut(duration: 0.2), value: isToggled)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(CustomColors.innerBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
        )
    }
}
