//
//  CustomNavigationBarView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 25/02/2025.
//
import SwiftUI

struct CustomNavigationBarView: View {
    var leftIcon: String?
    var rightIcon: String?
    var leftAction: () -> Void = {}
    var rightAction: () -> Void = {}
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                if let leftIcon = leftIcon {
                    makeNavigationSectionButton(icon: leftIcon, action: leftAction)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                if let rightIcon = rightIcon {
                    makeNavigationSectionButton(icon: rightIcon, action: rightAction)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing)
                }
            }
        }
    }

    @ViewBuilder
    func makeNavigationSectionButton(icon: String, action: @escaping (() -> Void)) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 9)
                        .fill(CustomColors.innerBackground)
                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
        }
    }
}
