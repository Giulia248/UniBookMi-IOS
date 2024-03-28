//
//  ViewConfigs.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 28/03/24.
//

import Foundation
import SwiftUI

// MARK: colors palette

final class UniBookMiColors{
    static let shared = UniBookMiColors()

    let darkBlue3 = Color(hex: "#020247") // darker
    let darkBlue2 = Color(hex: "#002db3")
    let darkBlue1 = Color(hex: "#3131df")

    let lightBlue3 = Color(hex: "#7ea3de") // darker
    let lightBlue2 = Color(hex: "#809fff")
    let lightBlue1 = Color(hex: "#bfcfff")

    internal func backgroundColor() -> LinearGradient{
        LinearGradient(colors: [.white, .white, UniBookMiColors.shared.lightBlue1], startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    internal func debugBackgroundColor() -> LinearGradient{
        LinearGradient(colors: [.red, .orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
    }


}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0

        Scanner(string: cleanHexCode).scanHexInt64(&rgb)

        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

// MARK: font
final class UniBookMiFont{
    static let shared = UniBookMiFont()

    internal func nunitoSmall() -> Font{
        Font.custom("Nunito-VariableFont_wght", size: 10)
    }
    internal func nunitMedium() -> Font{
        Font.custom("Nunito-VariableFont_wght", size: 20)
    }
    internal func nunitoBig() -> Font{
        Font.custom("Nunito-VariableFont_wght", size: 30)
    }


}
