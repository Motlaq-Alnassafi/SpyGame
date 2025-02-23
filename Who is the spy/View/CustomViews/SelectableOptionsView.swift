//
//  SelectableOptionsView.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import SwiftUI
import SwiftUICore

enum Selection: String {
    case general
    case kuwait
}

struct SelectableOptionsView: View {
    @State private var selectedOption: Selection = .general

    var body: some View {
        HStack(spacing: 15) {
            // General Option
            SelectableCard(
                isSelected: selectedOption == .general,
                title: "General",
                icon: AnyView(
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 30))
                )
            )
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedOption = .general
                }
            }

            // Kuwait Option
            SelectableCard(
                isSelected: selectedOption == .kuwait,
                title: "Kuwait",
                icon: AnyView(KuwaitFlag())
            )
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedOption = .kuwait
                }
            }
        }
        .padding()
    }
}

struct SelectableCard: View {
    let isSelected: Bool
    let title: String
    let icon: AnyView

    var body: some View {
        VStack {
            icon
                .frame(width: 30, height: 20)
            Text(title)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected ? Color.blue : Color.blue.opacity(0.1))
        )
        .foregroundColor(isSelected ? .white : .primary)
        .animation(.easeInOut, value: isSelected)
    }
}

// Kuwait Flag Component
struct KuwaitFlag: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Green top section
                Rectangle()
                    .fill(Color(red: 0, green: 0.4, blue: 0))
                    .frame(height: geometry.size.height / 3)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 6)

                // White middle section
                Rectangle()
                    .fill(Color.white)
                    .frame(height: geometry.size.height / 3)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)

                // Red bottom section
                Rectangle()
                    .fill(Color.red)
                    .frame(height: geometry.size.height / 3)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 5 / 6)

                // Black trapezoid on the left
                Path { path in
                    let width = geometry.size.width * 0.35
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: width, y: geometry.size.height * 0.2))
                    path.addLine(to: CGPoint(x: width, y: geometry.size.height * 0.8))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(Color.black)
            }
        }
    }
}

struct SelectableOptionsView_Preview: PreviewProvider {
    static var previews: some View {
        SelectableOptionsView()
    }
}
