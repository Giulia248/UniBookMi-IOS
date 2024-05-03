//
//  UniBookMiButton.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 28/03/24.
//

import SwiftUI

struct UniBookMiButton: View {

    var text: String = ""
    @Binding var isEnabled: Bool

    let action: () -> Void


    var body: some View {

            Button {
                action()
            } label: {
                Text(text)
                    .font(UniBookMiFont.shared.nunitMedium())
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                isEnabled ? LinearGradient(colors: [UniBookMiColors.shared.darkBlue2], startPoint: .topLeading, endPoint: .bottomTrailing) :
                LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing)


            )
            .cornerRadius(20)
            .disabled(!(isEnabled))
    }
}

