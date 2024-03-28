//
//  Navigation.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 27/03/24.
//

import Foundation

struct NavigationItem: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var icon: String
    var menu: Menu

}

enum Menu: String {
    case login
}
