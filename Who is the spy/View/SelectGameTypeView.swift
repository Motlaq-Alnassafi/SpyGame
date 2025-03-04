//
//  SelectGameTypeView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 01/03/2025.
//

import SwiftUI
import SwiftUICore

struct SelectGameTypeView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var showingRules = false

    var body: some View {
        VStack(spacing: .zero) {
            CustomNavigationBarView(leftIcon: "house",
                                    rightIcon: "questionmark".localized,
                                    leftAction: { viewModel.showingIntro = true
                                        viewModel.gameState = .setup
                                    },
                                    rightAction: { showingRules = true })
                .padding(.top, 20)

            Text("ChooseGameType".localized)
                .font(.custom("Geist", size: 48))
                .fontWeight(.bold)
                .padding(.top, 32)
                .padding(.horizontal)
                .padding(.bottom)

            Spacer()

            HStack {
                makeGameTypeButton(text: "locationsInKuwait".localized, icon: "KuwaitTowers", action: {
                    viewModel.category = CategoryItem.KuwaitLocations
                    viewModel.gameState = .setup
                    viewModel.gameType = .location
                })
                makeGameTypeButton(text: "GeneralLocations".localized, icon: "GeneralLocations", action: {
                    viewModel.category = CategoryItem.generalLocations
                    viewModel.gameState = .setup
                    viewModel.gameType = .location
                })
            }
            .padding(.horizontal)
            .padding(.bottom, 8)

            HStack {
                makeGameTypeButton(text: "Animals".localized, icon: "Camel", action: {
                    viewModel.category = CategoryItem.animals
                    viewModel.gameState = .setup
                    viewModel.gameType = .animal
                })
                makeGameTypeButton(text: "KuwaitAreas".localized, icon: "Kuwait", action: {
                    viewModel.category = CategoryItem.kuwaitAreas
                    viewModel.gameState = .setup
                    viewModel.gameType = .kuwaitAreas
                })
            }
            .padding(.horizontal)

            Spacer()
        }
        .fullScreenCover(isPresented: $showingRules) {
            GameRulesView()
        }
    }

    @ViewBuilder
    func makeGameTypeButton(text: String, icon: String, action: @escaping (() -> Void)) -> some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#1A0A00"), Color(hex: "120600"), Color(hex: "#0A0400"), Color(hex: "#0A0400")]),

                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color(hex: "#FF7519"), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 10)
                    .overlay(
                        VStack {
                            Text(text)
                                .font(.custom("Geist", size: 24))
                                .foregroundColor(.white)
                                .padding(.top, 25)

                            Spacer()

                            Image(icon)
                                .resizable()
                                .frame(width: 105, height: 100, alignment: .bottom)

                            Spacer()
                        }
                    )
            }
            .frame(height: 250)
            .frame(width: UIScreen.main.bounds.width / 3 * 1.25)
        }
    }
}
