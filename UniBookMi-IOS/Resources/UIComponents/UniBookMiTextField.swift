//
//  UniBookMiTextField.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 28/03/24.
//

import SwiftUI

struct UniBookMiTextField: View {

    @Binding var stringField: String
    var prompt: String = "field"

    var body: some View {
        TextField("", text: $stringField ,
                  prompt: Text(prompt)
            .font(UniBookMiFont.shared.nunitMedium())
            .bold()
            .foregroundColor(Color(hex: "1d1b21"))


        )
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 20)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background( Color(hex: "#d4d2d9").opacity(0.3))
        .cornerRadius(15)
        .padding(.horizontal, 20)
    }
}

struct UniBookMiSecureTextField: View {

    @Binding var stringField: String
    var prompt: String = "field"
    @State var showText: Bool = false

    var body: some View {

        HStack{

            Group{
                if showText{
                    TextField("", text: $stringField ,
                              prompt: Text(prompt)
                        .font(UniBookMiFont.shared.nunitMedium())
                        .bold()
                        .foregroundColor(Color(hex: "1d1b21"))


                    )
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background( Color(hex: "#d4d2d9").opacity(0.3))
                    .cornerRadius(15)
                } else {
                    SecureField("", text: $stringField ,
                              prompt: Text(prompt)
                        .font(UniBookMiFont.shared.nunitMedium())
                        .bold()
                        .foregroundColor(Color(hex: "1d1b21"))


                    )
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background( Color(hex: "#d4d2d9").opacity(0.3))
                    .cornerRadius(15)
                }
            }

            Button {
                showText.toggle()
            } label: {
                Image(systemName: showText ? "eye.slash" : "eye")
                    .foregroundColor(.black)
            }

        }
        .padding(.horizontal)

    }
}
