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



    init(){


    }
}

/// global func to log on console
public func UniBookMiLog(_ text: String, file: String = #file, line: Int = #line, function: String = #function, _ alert: Bool? = nil) {
    let alertIcon = (alert != nil && alert == true) ? "❗️" : "--"
    let fileName = file.components(separatedBy: "UniBookMi-IOS").last ?? ""
    print("--------\(alertIcon)--------")
    print("path -> \(fileName) line \(line) function -> \(function)")
    print("DEBUG message -> \(text)")
    print("------------------")

}
