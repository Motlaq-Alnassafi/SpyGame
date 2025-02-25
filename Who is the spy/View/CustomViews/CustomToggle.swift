//
//  CustomToggle.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 25/02/2025.
//

import SwiftUI

struct CustomToggle: View {
    @State private var isToggled: Bool = false
    @Binding var toggled: Bool
    var text: String
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))

            Spacer()

            Button(action: {
                toggled = isToggled == false ? false : true

                toggled.toggle()
                isToggled.toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isToggled ? Color(hex: "#FF6600") : Color.gray.opacity(0.3))
                        .frame(width: 50, height: 30)

                    Circle()
                        .fill(Color.black)
                        .frame(width: 28, height: 30)
                        .offset(x: isToggled ? 10 : -10)
                        .animation(.easeInOut(duration: 0.2), value: isToggled)
                }
            }
        }
    }
}
