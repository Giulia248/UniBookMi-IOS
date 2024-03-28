//
//  ContentView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 22/03/24.
//

import SwiftUI

struct ContentView: View {

    var navigationItems = [

        NavigationItem(title: "Login", icon: "person.circle", menu: .login),
    ]

    var body: some View {
        NavigationStack {
            List(navigationItems) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.icon)
                        .foregroundColor(.primary)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Main menu")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NavigationItem.self) { item in
                switch item.menu {
                case .login:
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
