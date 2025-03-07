//
//  GameTimerManager.swift
//  WHO'S THE SPY
//
//  Created by Motlaq Alnassafi on 06/03/2025.
//

import Combine
import Foundation

class GameTimerManager: ObservableObject {
    @Published var remainingSeconds: Int = 8 * 60
    @Published private var timer: AnyCancellable?

    func startTimer(onEnd: @escaping () -> Void) {
        timer?.cancel()
        remainingSeconds = 8 * 60

        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.remainingSeconds > 0 {
                    if self.remainingSeconds == 11 {
                        AudioManager.shared.playSound("countDown")
                    }
                    self.remainingSeconds -= 1
                } else {
                    self.timer?.cancel()
                    print("Timer Ended")
                    onEnd()
                }
            }
    }

    func pauseTimer() {
        timer?.cancel()
    }

    func resetTimer(to seconds: Int = 8 * 60) {
        timer?.cancel()
        remainingSeconds = seconds
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}
