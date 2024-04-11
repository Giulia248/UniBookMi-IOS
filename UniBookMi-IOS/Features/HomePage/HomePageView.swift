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

    @State var viewModel: HomePageViewModel

    @State var allowButton = true
    @State var errorLogout = false
    @State var errorLogoutString = "errore"

    var body: some View {

        VStack{
            Text("UniBookMi")

            Text("Benvenuto \(viewModel.authService.user?.name ?? "")")
                .font(UniBookMiFont.shared.nunitMedium())

            UniBookMiButton(text: "Logout", isEnabled: $allowButton) {

                viewModel.logout { error in
                    if let error {
                        errorLogout = true
                        errorLogoutString = error.localizedDescription

                    }

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
