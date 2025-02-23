//
//  PassPhoneAnimation.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUICore

struct PassPhoneAnimation: View {
    @State private var phoneOffset: CGFloat = -50
    @State private var phoneRotation: Double = -10
    @State private var arrowOffset: CGFloat = 0
    @State private var arrowOpacity: Double = 0

    var body: some View {
        ZStack {
            Image(systemName: "iphone")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .foregroundColor(.white)
                .offset(x: phoneOffset)
                .rotationEffect(.degrees(phoneRotation))

            Image(systemName: "arrow.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
                .foregroundColor(.indigo)
                .offset(x: arrowOffset)
                .opacity(arrowOpacity)
        }
        .onAppear {
            withAnimation(
                Animation
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true)
            ) {
                phoneOffset = 50
                phoneRotation = 10
                arrowOffset = 30
                arrowOpacity = 1
            }
        }
    }
}
