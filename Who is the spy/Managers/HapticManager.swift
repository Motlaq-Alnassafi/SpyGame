//
//  HapticManager.swift
//  WHO'S THE SPY
//
//  Created by Motlaq Alnassafi on 06/03/2025.
//

import UIKit

enum HapticFeedbackStyle {
    case light
    case medium
    case heavy
    case success
    case warning
}

class HapticManager {
    static let shared = HapticManager()

    private init() {}

    func hapticFeedback(style: HapticFeedbackStyle) {
        switch style {
        case .light:
            lightImpact()
        case .medium:
            mediumImpact()
        case .heavy:
            heavyImpact()
        case .success:
            successNotification()
        case .warning:
            warningNotification()
        }
    }

    private func lightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    private func mediumImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    private func heavyImpact() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    private func successNotification() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    private func warningNotification() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    private func selectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
