//
//  LoginView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 27/03/24.
//

import SwiftUI

struct LoginView: View {

    // strings
    @State var fullName: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @State private var title: String = "Autenticazione"

    // bool
    @State private var loginButtonEnabled = false
    @State private var registerButtonEnabled = true
    @State private var isLogin = true
    @State private var showAlertLogin = false
    @State private var showAlertRegister = false

    @State private var viewModel = LoginViewModel()

    var body: some View {

        GeometryReader { geometry in
            Group {
                VStack(alignment: .center, spacing: 15) {
                    Spacer()
                    Text(title)
                        .font(UniBookMiFont.shared.nunitoBig())
                        .transition(.opacity)
                    Spacer()

                    if !isLogin{
                        UniBookMiTextField(stringField: $fullName, prompt: "Nome")
                            .onChange(of: fullName) {
                                registerButtonEnabled = viewModel.isLoginEnabled(email: name, password: password) && !fullName.isEmpty
                            }
                    }

                    UniBookMiTextField(stringField: $name, prompt: "Email")
                        .onChange(of: name) {
                            if !isLogin {
                                registerButtonEnabled = !fullName.isEmpty && viewModel.isLoginEnabled(email: name, password: password)
                            } else {
                                loginButtonEnabled = viewModel.isLoginEnabled(email: name, password: password)
                            }
                        }
                    UniBookMiSecureTextField(stringField: $password, prompt: "Password", showText: false)
                        .onChange(of: password) {
                            if !isLogin {
                                registerButtonEnabled = !fullName.isEmpty && viewModel.isLoginEnabled(email: name, password: password)
                            } else {
                                loginButtonEnabled = viewModel.isLoginEnabled(email: name, password: password)
                            }

                        }
                    Spacer()

                    // MARK: Login \ register button
                    HStack{

                        // login BUTTON
                        UniBookMiButton(text: "Accedi", isEnabled: $loginButtonEnabled, action: {

                            if isLogin { // if is already login

                                print("hai acceduto")
                                showAlertLogin.toggle()

                            }else {
                                withAnimation {
                                    isLogin = true
                                    title = "Autenticazione"
                                    loginButtonEnabled = false
                                    registerButtonEnabled = true
                                }

                            fullName = ""
                            name = ""
                            password = ""
                            }

                        })
                        .alert("Hai fatto accesso", isPresented: $showAlertLogin) {
                            Button("OK", role: .cancel) {
                                showAlertLogin.toggle()
                            }
                        }

                        // register BUTTON
                        UniBookMiButton(text: "Registrati", isEnabled: $registerButtonEnabled, action: {

                            if !isLogin{
                                print("hai fatto registrazione")
                                showAlertRegister.toggle()
                            }
                            else{
                                withAnimation {
                                    isLogin = false
                                    title = "Registrazione"
                                    loginButtonEnabled = true
                                    registerButtonEnabled = false
                                }

                                fullName = ""
                                name = ""
                                password = ""

                            }

                        })
                        .alert("Ti sei registrato", isPresented: $showAlertRegister) {
                            Button("OK", role: .cancel) {
                                showAlertRegister.toggle()
                            }
                        }
                    }
                }
                .animation(.smooth, value: isLogin)

                .background(.white)
                .frame(alignment: .center)
                .cornerRadius(15)
                .padding(.horizontal, 10)
                .padding(.vertical, geometry.size.height / 3.8)
                .shadow(radius: 5)

            }

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
