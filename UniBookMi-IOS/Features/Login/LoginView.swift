//
//  LoginView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 27/03/24.
//

import SwiftUI
import FirebaseCore

struct LoginView: View {

    @State var viewModel: LoginViewModel

    // strings
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State private var title: String = UniBookMiStrings.autenticazione
    @State private var errorMessage: String = UniBookMiStrings.errore
    @State private var passwordText: String = ""

    // bool
    @State private var loginButtonEnabled = false
    @State private var registerButtonEnabled = true
    @State private var isLogin = true

    @State private var showAlertError = false

    var body: some View {

        GeometryReader { geometry in
            Group {
                VStack(alignment: .center, spacing: 15) {
                    Spacer()
                    Text(title)
                        .font(UniBookMiFont.shared.nunitoBig())
                        .transition(.opacity)
                    Spacer()

                    // MARK: Fields
                    if !isLogin {
                        UniBookMiTextField(stringField: $fullName, prompt: UniBookMiStrings.nome)
                            .onChange(of: fullName) {

                                registerButtonEnabled = viewModel.isLoginEnabled(email: email, password: password) && !fullName.isEmpty
                            }
                    }

                    UniBookMiTextField(stringField: $email, prompt: "Email")
                        .onChange(of: email) {

                            // all lowercase
                            email = email.lowercased()

                            if !isLogin {
                                registerButtonEnabled = !fullName.isEmpty && viewModel.isLoginEnabled(email: email, password: password)
                            } else {
                                loginButtonEnabled = viewModel.isLoginEnabled(email: email, password: password)
                            }
                        }
                    UniBookMiSecureTextField(stringField: $password, prompt: "Password", showText: false)
                        .onChange(of: password) {

                            passwordText = (password.count >= 6) || isLogin ? "" : UniBookMiStrings.passwordSeiCaratteri

                            if !isLogin {
                                registerButtonEnabled = !fullName.isEmpty && viewModel.isLoginEnabled(email: email, password: password)
                            } else {
                                loginButtonEnabled = viewModel.isLoginEnabled(email: email, password: password)
                            }
                        }
                    Spacer()

                    Text(passwordText)
                        .lineLimit(2, reservesSpace: true)
                        .font(UniBookMiFont.shared.nunitMedium())
                        .animation(.snappy, value: passwordText)



                    // MARK: Login \ register button
                    HStack{

                        // login BUTTON
                        UniBookMiButton(text: UniBookMiStrings.accedi, isEnabled: $loginButtonEnabled, action: {

                            if isLogin { // if is already login

                                viewModel.login(email: email, password: password) { errorDescription in
                                    if !(errorDescription.isEmpty) {
                                        showAlertError = true
                                        errorMessage = errorDescription

                                    }
                                }

                            }else {
                                withAnimation {
                                    passwordText = ""
                                    isLogin = true
                                    title = UniBookMiStrings.autenticazione
                                    loginButtonEnabled = false
                                    registerButtonEnabled = true
                                }

                                fullName = ""
                                email =  ""
                                password = ""
                            }

                        })
                        // register BUTTON
                        UniBookMiButton(text: UniBookMiStrings.registrati, isEnabled: $registerButtonEnabled, action: {

                            if !isLogin{

                                viewModel.register(email: email, password: password, name: fullName) { errorDescription in
                                    if !(errorDescription.isEmpty) {
                                        showAlertError = true
                                        errorMessage = errorDescription
                                    }
                                }

                            }
                            else{
                                withAnimation {
                                    passwordText = UniBookMiStrings.passwordSeiCaratteri
                                    isLogin = false
                                    title = UniBookMiStrings.registrazione
                                    loginButtonEnabled = true
                                    registerButtonEnabled = false
                                }

                                fullName = ""
                                email =  ""
                                password = ""

                            }

                        })
                    }
                }
                .animation(.smooth, value: isLogin)
                .alert("Error: \(errorMessage)", isPresented: $showAlertError) {
                    Button("OK", role: .cancel) {
                        showAlertError.toggle()
                    }
                }


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
