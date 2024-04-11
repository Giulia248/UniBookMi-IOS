//
//  HomePageView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 09/04/24.
//

import SwiftUI
import ProgressHUD
import FirebaseCore

struct HomePageView: View {

    @EnvironmentObject var authService: AuthService

    @State var allowButton = true
    @State var errorLogout = false
    @State var errorLogoutString = "errore"

    var body: some View {

        VStack{
            Text("UniBookMi")

            Text("Benvenuto \(authService.user?.name ?? "")")
                .font(UniBookMiFont.shared.nunitMedium())

            UniBookMiButton(text: "Logout", isEnabled: $allowButton) {

                ProgressHUD.animate(nil, GlobalConfigurations.shared.loadingAnimation)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
                    ProgressHUD.dismiss()
                }
                
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
