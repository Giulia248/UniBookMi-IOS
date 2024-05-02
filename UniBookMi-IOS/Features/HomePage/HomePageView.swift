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
    @State var errorLogoutString = UniBookMiStrings.errore

    var body: some View {

        VStack{

            HStack {
                Text(UniBookMiStrings.title)
                    .font(UniBookMiFont.shared.nunitMedium())
                    .foregroundStyle(LinearGradient(colors: [UniBookMiColors.shared.darkBlue2],
                                                    startPoint: .leading, endPoint: .trailing))
                    .tint(UniBookMiColors.shared.darkBlue2)
                Text(UniBookMiStrings.homePage)
                    .font(UniBookMiFont.shared.nunitMedium())
                    .foregroundStyle(LinearGradient(colors: [Color(hex: "#7D7F7F")],
                                                    startPoint: .leading, endPoint: .trailing))
            }

            Text("\(UniBookMiStrings.benvenuto) \(viewModel.authService.user?.name ?? "")")
                .font(UniBookMiFont.shared.nunitMedium())

            UniBookMiButton(text: UniBookMiStrings.logout, isEnabled: $allowButton) {

                viewModel.logout { error in
                    if let error {
                        errorLogout = true
                        errorLogoutString = error.localizedDescription

                    }

                }
            }
            .alert("\(UniBookMiStrings.errore) \(errorLogoutString)", isPresented: $errorLogout) {
                Button("OK", role: .cancel) {
                    errorLogout = false
                }
            }


        }
    }
}
