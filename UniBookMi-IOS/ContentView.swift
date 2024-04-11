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
                } else {
                    LoginView(viewModel: LoginViewModel(authService: authService))
                }
        }
        .animation(.smooth, value: authService.signedIn)

    }

}
