//
//  LoginView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 27/03/24.
//

import SwiftUI

struct LoginView: View {

    @State var name: String = "a@.com"
    @State var password: String = "a"
    @State var showPassword: Bool = false
    @State private var viewModel = LoginViewModel()

    var body: some View {
        GeometryReader{ geometry in

                    VStack(alignment: .center, spacing: 15) {
                        Spacer()
                        Text("Autenticazione")
                            .font(.)
                        Spacer()

                        TextField("Name",
                                  text: $name ,
                                  prompt: Text("Email").foregroundColor(.blue)
                        )
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 2)
                        }
                        .padding(.horizontal)

                        HStack {
                            Group {
                                if showPassword {
                                    TextField("Password", // how to create a secure text field
                                              text: $password,
                                              prompt: Text("Password").foregroundColor(.red)) // How to change the color of the TextField Placeholder
                                } else {
                                    SecureField("Password", // how to create a secure text field
                                                text: $password,
                                                prompt: Text("Password").foregroundColor(.red)) // How to change the color of the TextField Placeholder
                                }
                            }
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                            }

                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.red) // how to change image based in a State variable
                            }

                        }.padding(.horizontal)

                        Spacer()

                        Button {
                            // loginaction
                        } label: {
                            Text("Sign In")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
                        .background(
                            viewModel.isLoginEnabled(email: name, password: password) ? // how to add a gradient to a button in SwiftUI if the button is disabled
                            LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                                LinearGradient(colors: [UniBookMiColors.shared.darkBlue2], startPoint: .topLeading, endPoint: .bottomTrailing)

                        )
                        .cornerRadius(20)
                        .disabled(viewModel.isLoginEnabled(email: name, password: password)) // how to disable while some condition is applied
                        .padding()
                    }

                    .background(.white)
                    .frame(alignment: .center)
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .padding(.vertical, geometry.size.height / 4)




        }
        .background(
            UniBookMiColors.shared.debugBackgroundColor()
        )
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
