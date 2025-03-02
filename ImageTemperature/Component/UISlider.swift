//
//  UISlider.swift
//  ImageTemperature
//
//  Created by Satrio Wicaksono on 02/03/25.
//

import SwiftUI

struct UISlider: View {
    @Binding var value: Float
    let range: ClosedRange<Float>
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .trailing, endPoint: .leading)
                .frame(height: 4)
                .cornerRadius(2)
            
            // Slider
            Slider(value: $value, in: range, step: 1)
                .accentColor(.clear) // Make the default slider color clear
        }
        .padding(.horizontal)
    }
}

struct UISlider_Previews: PreviewProvider {
    static var previews: some View {
        UISlider(value: .constant(0), range: -100...100)
    }
}
