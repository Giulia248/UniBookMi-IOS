//
//  GlobalConfigurations.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 11/04/24.
//

import Foundation
import ProgressHUD


final class GlobalConfigurations {

    static let shared = GlobalConfigurations()

    internal let loadingAnimation = AnimationType.horizontalDotScaling

    public func UniBookMiLog(_ text: String, _ function: String, _ alert: Bool? = nil) {
        var alertIcon = alert != nil ? "❗️" : ""
        print("--------\(alertIcon)---------")
        print("Function -> \(function)")
        print("debugs -> \(text)")
        print("----------\(alertIcon)-------")

    }


    init(){


    }
}
