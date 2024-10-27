//
//  ContentView.swift
//  CollorizedAppBySwiftUI
//
//  Created by Winky51 on 24.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var firstRed: Double = .random(in: 0...255)
    @State private var firstGreen: Double = .random(in: 0...255)
    @State private var firstBlue: Double = .random(in: 0...255)
    
    @State private var secondRed: Double = .random(in: 0...255)
    @State private var secondGreen: Double = .random(in: 0...255)
    @State private var secondBlue: Double = .random(in: 0...255)
    
    @FocusState private var focusedField: Field?
    
    private var gradient: Gradient {
        Gradient(colors: [firstColor, secondColor])
    }
    private var firstColor: Color {
        Color(
            red: firstRed / 255,
            green: firstGreen / 255,
            blue: firstBlue / 255
        )
    }
    private var secondColor: Color {
        Color(
            red: secondRed / 255,
            green: secondGreen / 255,
            blue: secondBlue / 255
        )
    }
    
    var body: some View {
        VStack {
            
            LinearGradient(
                gradient: gradient,
                startPoint: .leading,
                endPoint: .trailing
            )
                .frame(height: 200)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(color: .black, radius: 5)
            
            VStack(spacing: 20) {
                Text("First Color")
                    .font(.system(size: 25))
                
                ColorSlider(
                    value: $firstRed,
                    focused: $focusedField,
                    color: .red,
                    field: .firstRed
                )
                
                
                ColorSlider(
                    value: $firstGreen,
                    focused: $focusedField,
                    color: .green,
                    field: .firstGreen
                )
                
                ColorSlider(
                    value: $firstBlue,
                    focused: $focusedField,
                    color: .blue,
                    field: .firstBlue
                )
                
                Text("Second Color")
                    .font(.system(size: 25))
                
                ColorSlider(
                    value: $secondRed,
                    focused: $focusedField,
                    color: .red,
                    field: .secondRed
                )
                
                ColorSlider(
                    value: $secondGreen,
                    focused: $focusedField,
                    color: .green,
                    field: .secondGreen
                )
                
                ColorSlider(
                    value: $secondBlue,
                    focused: $focusedField,
                    color: .blue,
                    field: .secondBlue
                )
                
                
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    enum Field {
        case firstRed, firstGreen, firstBlue, secondRed, secondGreen, secondBlue
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    @FocusState.Binding var focused: ContentView.Field?
    
    var color: Color
    var field: ContentView.Field
    
    var body: some View {
        HStack {
            Text("\(Int(value))")
                .frame(width: 40)
            
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
            
            TextField("", value: $value, formatter: NumberFormatter())
                .colorEditor(color, field: field)
                .focused($focused, equals: field)
            
        }
        
    }
    
}

struct ColorSliderModifier: ViewModifier {
    
    let color: Color
    let field: ContentView.Field
    
    func body(content: Content) -> some View {
        content
            .frame(width: 60)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color, lineWidth: 1)
            }
    }
}

extension TextField {
    func colorEditor( _ color: Color, field: ContentView.Field) -> some View {
        modifier(ColorSliderModifier(color: color, field: field))
        
    }
}

