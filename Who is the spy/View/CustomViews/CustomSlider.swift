//
//  CustomSlider.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 25/02/2025.
//

import SwiftUI

struct CustomSlider: UIViewRepresentable {
    @Binding var value: Int
    var minimumValue: Int
    var maximumValue: Int
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = Float(minimumValue)
        slider.maximumValue = Float(maximumValue)
        slider.value = Float(value)

        slider.isContinuous = true

        let thumbSize = CGSize(width: 30, height: 30)
        let thumbImage = createThumbImage(color: UIColor(hex: "#FF6600"), size: thumbSize, borderColor: .white, borderWidth: 3)
        slider.setThumbImage(thumbImage, for: .normal)

        slider.minimumTrackTintColor = UIColor(hex: "#FF6600")
        slider.maximumTrackTintColor = UIColor(hex: "#E8E6EA")

        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)

        return slider
    }

    func updateUIView(_ uiView: UISlider, context _: Context) {
        if Int(round(uiView.value)) != value {
            uiView.value = Float(value)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomSlider

        init(_ parent: CustomSlider) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: UISlider) {
            let newValue = Int(round(sender.value))

            if newValue != parent.value {
                DispatchQueue.main.async {
                    self.parent.value = newValue
                }
            }
        }
    }

    private func createThumbImage(color: UIColor, size: CGSize, borderColor: UIColor, borderWidth: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)

            borderColor.setFill()
            context.cgContext.fillEllipse(in: rect)

            let innerRect = rect.insetBy(dx: borderWidth, dy: borderWidth)
            color.setFill()
            context.cgContext.fillEllipse(in: innerRect)
        }
    }
}
