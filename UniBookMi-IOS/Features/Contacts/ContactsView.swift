//
//  ContactsView.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 07/05/24.
//

import SwiftUI

struct ContactsView: View {

    var colorText: Color
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        ZStack {
            Image("university")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.3)
            VStack {
                Text("EVVVIVA")
                    .foregroundStyle(LinearGradient(colors: [colorText],
                                                    startPoint: .leading, endPoint: .trailing))
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
