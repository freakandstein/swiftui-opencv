//
//  UIButton.swift
//  ImageTemperature
//
//  Created by Satrio Wicaksono on 01/03/25.
//

import SwiftUI

enum ButtonStyle {
    case normal
    case disabled
    case danger
    
    var backgroundColor: Color {
        switch self {
        case .normal:
            return .blue
        case .disabled:
            return .gray
        case .danger:
            return .red
        }
    }
}

struct UIButton: View {
    let text: String
    let state: ButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(state.backgroundColor)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .disabled(state == .disabled)
    }
}

struct UIButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UIButton(text: "Normal Button", state: .normal, action: {})
            UIButton(text: "Disabled Button", state: .disabled, action: {})
            UIButton(text: "Danger Button", state: .danger, action: {})
        }
        .padding()
    }
}
