//
//  ContentView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 22/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authService = AuthService()

    var body: some View {
        VStack{
            if authService.signedIn{
                HomePageView()
                    .environmentObject(authService)
            } else {
                LoginView()
                    .environmentObject(authService)

            }
        }
        .animation(.smooth, value: authService.signedIn)

    }

}

#Preview {
    ContentView()
}
