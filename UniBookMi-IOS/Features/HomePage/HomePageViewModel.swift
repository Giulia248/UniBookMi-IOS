//
//  HomePageViewModel.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 11/04/24.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseAuth
import ProgressHUD
import FirebaseFirestore

final class HomePageViewModel: ObservableObject {

    var authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }


    internal func logout(completion: @escaping (Error?) -> Void) {

        ProgressHUD.animate(nil, GlobalConfigurations.shared.loadingAnimation)

        authService.regularSignOut { error in
            completion(error)
            return
        }
        completion(nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
            ProgressHUD.dismiss()
        }

    }



}
