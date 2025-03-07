//
//  SettingsManager.swift
//  WHO'S THE SPY
//
//  Created by Motlaq Alnassafi on 06/03/2025.
//

import AVFoundation
import Foundation
import UIKit

class SettingsManager: ObservableObject {
    @Published var hapticFeedback = true
    @Published var soundEffects = true
    @Published var customPlayerNames = false
    @Published var showSpiesToEachOther = false

    func triggerHapticFeedback(style: HapticFeedbackStyle) {
        guard hapticFeedback else { return }
        HapticManager.shared.hapticFeedback(style: .heavy)
    }

    func playSoundEffect(_ soundName: String) {
        guard soundEffects else { return }
        AudioManager.shared.playSound(soundName)
    }
}
