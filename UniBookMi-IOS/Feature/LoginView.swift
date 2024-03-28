//
//  LoginView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 27/03/24.
//

import SwiftUI

struct LoginView: View {

    // strings
    @State var name: String = ""
    @State var password: String = ""
    @State private var title: String = "Autenticazione"

    // bool
    @State private var buttonsEnabled = false
    @State private var isLogin = true

    @State private var viewModel = LoginViewModel()






    var body: some View {
        GeometryReader{ geometry in

            VStack(alignment: .center, spacing: 15) {
                Spacer()
                Text(title)
                    .font(UniBookMiFont.shared.nunitoBig())
                    .transition(.opacity)
                Spacer()

                UniBookMiTextField(stringField: $name, prompt: "Email")
                    .onChange(of: name) {
                        buttonsEnabled = viewModel.isLoginEnabled(email: name, password: password)
                    }
                UniBookMiSecureTextField(stringField: $password, prompt: "Password", showText: false)
                    .onChange(of: password) {
                        buttonsEnabled = viewModel.isLoginEnabled(email: name, password: password)
                    }
                Spacer()

                // MARK: Login \ register button
                HStack{

                    // login
                    UniBookMiButton(text: "Accedi", isEnabled: $buttonsEnabled, action: {
                        print("Efefe accedi")
                        print("password e email \(name) \(password)")
                    })

                    // register
                    UniBookMiButton(text: "Registrati", isEnabled: $buttonsEnabled, action: {
                        print("Efefe registtra")
                    })
                }
            }
            .background(.white)
            .frame(alignment: .center)
            .cornerRadius(15)
            .padding(.horizontal, 10)
            .padding(.vertical, geometry.size.height / 4)
            .shadow(radius: 5)
        }
        .background(
            UniBookMiColors.shared.backgroundColor()
        )
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
