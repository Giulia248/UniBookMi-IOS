//
//  UniBookMiFont.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 28/03/24.
//

import Foundation
import SwiftUI

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
