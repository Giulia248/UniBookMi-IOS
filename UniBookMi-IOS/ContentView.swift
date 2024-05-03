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

                TabView {

                    HomePageView(viewModel: HomePageViewModel(authService: authService))
                        .tabItem {
                                            Label("Menu", systemImage: "list.dash")
                                        }
                }


            } else {
                LoginView(viewModel: LoginViewModel(authService: authService))
            }
        }
        .animation(.smooth, value: authService.signedIn)

    }

}
