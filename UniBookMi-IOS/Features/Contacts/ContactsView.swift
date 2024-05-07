//
//  ContactsView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 07/05/24.
//

import SwiftUI
import MessageUI

struct ContactsView: View {

    @EnvironmentObject var navigationManager: NavigationManager
    @State var result: Result<MFMailComposeResult, Error>? = nil
    private let iconSize = 50.0


    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("university")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.3)

                VStack {
                    Text(UniBookMiStrings.contactsTextOne)
                        .font(UniBookMiFont.shared.nunitMedium())
                        .lineLimit(8)
                        .padding(.horizontal, 20)

                    MailView()
                        .frame(height: geometry.size.height / 2)

                    VStack {

                        HStack { // address
                            Image(systemName: "house.circle")
                                .resizable()
                                .foregroundStyle(LinearGradient(colors: [.black], startPoint: .bottom, endPoint: .top))
                                .frame(width: iconSize, height: iconSize)
                            Text(UniBookMiStrings.contactsAddress)
                                .frame(width: geometry.size.width / 1.5, alignment: .leading)
                        }

                        HStack { // phone
                            Image(systemName: "phone.circle")
                                .resizable()
                                .foregroundStyle(LinearGradient(colors: [.black], startPoint: .bottom, endPoint: .top))
                                .frame(width: iconSize, height: iconSize)
                            Text(UniBookMiStrings.contactsPhone)
                                .frame(width: geometry.size.width / 1.5, alignment: .leading)
                        }

                        HStack { // email
                            Image(systemName: "envelope.circle")
                                .resizable()
                                .foregroundStyle(LinearGradient(colors: [.black], startPoint: .bottom, endPoint: .top))
                                .frame(width: iconSize, height: iconSize)
                            Text(UniBookMiStrings.contactsMail)
                                .frame(width: geometry.size.width / 1.5, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
                }
            }
        }
        .navigationTitle(UniBookMiStrings.contacts)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    navigationManager.popToRoot()
                } label: {
                    Image(systemName: "arrowshape.backward.circle")
                        .foregroundStyle(LinearGradient(colors: [.black], startPoint: .bottom, endPoint: .top))


                }
            }
        }
    }

}

//#Preview {
//    ContactsView()
//}
