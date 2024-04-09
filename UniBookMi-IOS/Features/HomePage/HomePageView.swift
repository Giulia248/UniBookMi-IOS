//
//  HomePageView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 09/04/24.
//

import SwiftUI

struct HomePageView: View {

    @EnvironmentObject var authService: AuthService

    @State var allowButton = true
    @State var errorLogout = false
    @State var errorLogoutString = "errore"

    var body: some View {

        VStack{
            Text("UniBookMi")

            UniBookMiButton(text: "Logout", isEnabled: $allowButton) {
                authService.regularSignOut { error in
                    errorLogout = true
                    errorLogoutString = error?.localizedDescription ?? "error unknown"
                }
            }
            .alert("Errore \(errorLogoutString)", isPresented: $errorLogout) {
                Button("OK", role: .cancel) {
                    errorLogout = false
                }
            }


        }
    }
}

#Preview {
    HomePageView()
}
