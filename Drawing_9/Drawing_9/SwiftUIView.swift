//
//  SwiftUIView.swift
//  Drawing_9
//
//  Created by Денис Мусатов on 07.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var colorCycle = 0.0
    
    @State private var lineWidth: CGFloat = 2.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle, lineWidth: lineWidth)
                .frame(width: 300, height: 300)
                
            Text("Line Width is: \(colorCycle)")
            Slider(value: $colorCycle).padding()
            
            Text("Line Width is: \(lineWidth)")
            
            Slider(value: $lineWidth, in: 1...50)
                .padding()
        }
        
    }
}

struct Arrow: Shape {
    var thick: CGFloat
    
    var animatableData: CGFloat {
        get { self.thick }
        set { self.thick = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addRect(CGRect(x: rect.minX, y: rect.midY - thick / 2, width: rect.width / 2, height: thick))
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        //path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        
        return path
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    var lineWidth: CGFloat

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: self.lineWidth)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
