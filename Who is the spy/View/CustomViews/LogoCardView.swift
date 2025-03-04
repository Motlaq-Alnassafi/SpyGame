//
//  LogoCardView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 25/02/2025.
//

import SwiftUI

struct LogoCardView: View {
    var title: String
    var description: String?
//    var logoFrame: CGFloat
    var logoHeight: CGFloat
    var logoWidth: CGFloat
    var logoPadding: CGFloat
    var frameHeight: CGFloat
    var frameWidth: CGFloat
    var body: some View {
        VStack(spacing: 10) {
            Image("spyIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: logoWidth, height: logoHeight)
                .shadow(radius: 10)
                .padding(.bottom, logoPadding)

            Text(title)
                .font(.custom("Geist", size: 24))
                .fontWeight(.bold)
                .foregroundColor(CustomColors.textColor)

            if let description = description {
                Text(description)
                    .font(.custom("Geist", size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(CustomColors.textColor)
            }
        }
        .padding()
        .frame(width: frameWidth, height: frameHeight)
        .background(CustomColors.innerBackground)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}
