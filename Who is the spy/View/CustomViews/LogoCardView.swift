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
    var logoFrame: CGFloat
    var logoPadding: CGFloat
    var frameHeight: CGFloat
    var frameWidth: CGFloat
    var body: some View {
        VStack(spacing: 16) {
            Image("spyIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: logoFrame, height: logoFrame)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding(.bottom, logoPadding)

            Text(title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(CustomColors.textColor)

            if let description = description {
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(CustomColors.descriptionColor)
            }
        }
        .padding()
        .frame(width: frameWidth, height: frameHeight)
        .background(CustomColors.innerBackground)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}
