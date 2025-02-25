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
            VStack(spacing: .zero) {
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
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.easeInOut(duration: 0.3), value: viewModel.gameState)
        }
        .background(CustomColors.applicationBackground)
        .preferredColorScheme(.dark)
    }
}

struct SpyGameView_Previews: PreviewProvider {
    static var previews: some View {
        SpyGameView()
    }
}
