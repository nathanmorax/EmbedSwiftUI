//
//  CustomButtonType.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//
import SwiftUI

enum CustomButtonType {
    case outline(color: Color)
    case filled(color: Color)
    
}

struct CustomButtonModifier: ViewModifier {
    let type: CustomButtonType
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(backgroundFor(type))
            .foregroundStyle(foregroundFor(type))
            .overlay(overlayFor(type))
            .cornerRadius(8)
    }
    
    private func backgroundFor(_ type: CustomButtonType) -> Color {
        switch type {
        case .outline:
            return Color.clear
        case .filled(let color):
            return color
        }
    }
    
    private func foregroundFor(_ type: CustomButtonType) -> Color {
        switch type {
        case .outline(let color):
            return color
        case .filled:
            return .white
        }
    }
    
    @ViewBuilder
    private func overlayFor(_ type: CustomButtonType) -> some View {
        switch type {
        case .outline(let color):
            RoundedRectangle(cornerRadius: 8)
                .stroke(color, lineWidth: 2)
        case .filled:
            EmptyView()
        }
    }
}

extension View {
    func customButtonStyle(_ type: CustomButtonType) -> some View {
        self.modifier(CustomButtonModifier(type: type))
    }
}
