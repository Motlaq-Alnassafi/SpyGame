//
//  SpyGameView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 22/02/2025.
//

// import Combine
import SwiftUI

struct SpyGameView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.2), Color(red: 0.05, green: 0.05, blue: 0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                switch viewModel.gameState {
                case .setup:
                    if viewModel.showingIntro {
                        IntroView(viewModel: viewModel)
                    } else {
                        GameSetupView(viewModel: viewModel)
                    }
                case .roleReveal:
                    RoleRevealView(viewModel: viewModel)
                case .playing:
                    GamePlayView(viewModel: viewModel)
                case .finished:
                    GameFinishedView(viewModel: viewModel)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.gameState)
        }
        .preferredColorScheme(.dark)
    }
}

struct SpyGameView_Previews: PreviewProvider {
    static var previews: some View {
        SpyGameView()
    }
}
