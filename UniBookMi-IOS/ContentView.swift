//
//  ContentView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 22/03/24.
//

import SwiftUI

struct ContentView: View {

    @StateObject var authService = AuthService()
    @StateObject var navigationManager = NavigationManager()
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack{
                if authService.signedIn{

                    TabView(selection: $navigationManager.root) {

                        HomePageView(viewModel: HomePageViewModel(authService: authService))
                            .tabItem {
                                Label(UniBookMiStrings.homePageTabBar, systemImage: "house.fill")
                            }
                            .environmentObject(navigationManager)
                    }
                    .navigationDestination(for: NavigationViews.self) { page in
                        switch page {
                        case .contacts:
                            ContactsView()
                                .environmentObject(navigationManager)

                        case .news:
                            EmptyView()
                        }

                    }
                } else {
                    LoginView(viewModel: LoginViewModel(authService: authService))
                }
            }
            .animation(.smooth, value: authService.signedIn)
        }

    }

}
