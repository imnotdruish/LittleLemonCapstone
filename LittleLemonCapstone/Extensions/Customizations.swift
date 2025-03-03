//
//  Customizations.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 3/1/25.
//

import SwiftUI

struct ButtonYellow: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundColor(configuration.isPressed ? .white : .black)
            .padding(10)
            .background(configuration.isPressed ? Color.llGreen : Color.llYellow)
            .cornerRadius(8)
            .padding(.horizontal)
    }
}

struct ButtonAccent: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.llGreen : .white)
            .padding(10)
            .background(configuration.isPressed ? .white : Color.llGreen)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.llGreen, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

struct ButtonAccentReverse: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .white : Color.llGreen)
            .padding(10)
            .background(configuration.isPressed ? Color.llGreen : .white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.llGreen, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

struct ButtonAccentToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .foregroundColor(configuration.isOn ? Color.llWhite : Color.llGreen)
            .background(configuration.isOn ? Color.llGreen : Color.llWhite)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.llGreen, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {

            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .background(configuration.isOn ? Color.llGreen : Color.llWhite)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                        .foregroundStyle(configuration.isOn ? Color.llWhite : Color.llGreen)
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            configuration.label

        }
    }
}

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.llWhite)
            .cornerRadius(10)
    }
}

extension Font {
    static func displayFont() -> Font {
        return Font.custom("Charter", size: 48).weight(.bold)
    }
    
    static func subTitleFont() -> Font {
        return Font.custom("Charter", size: 32).weight(.regular)
    }
    
    static func leadText() -> Font {
        return Font.custom("Helvetica Neue", size: 18).weight(.medium)
    }
    
    static func sectionTitle() -> Font {
        return Font.custom("Helvetica Neue", size: 20).weight(.black)
    }
    
    static func cardTitle() -> Font {
        return Font.custom("Helvetica Neue", size: 18).weight(.bold)
    }
    
    static func paragraphText() -> Font {
        return Font.custom("Helvetica Neue", size: 16).weight(.regular)
    }
    
    static func highlightText() -> Font {
        return Font.custom("Helvetica Neue", size: 16).weight(.medium)
    }

}

extension String {
    func formatPhoneNumber() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "(XXX) XXX-XXXX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}
