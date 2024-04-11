//
//  LoginViewModel.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 28/03/24.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseAuth
import ProgressHUD
import FirebaseFirestore

final class LoginViewModel: ObservableObject {

    var authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    internal func isLoginEnabled(email: String, password: String) -> Bool{
        return !(email.isEmpty) && !(password.isEmpty) && email.contains("@") && email.contains("unimi.it") && password.count >= 6
    }

    /// login function that returns description of the error if it occured occurred
    internal func login(email: String, password: String, completion: @escaping (String) -> Void){
        ProgressHUD.animate("", AnimationType.ballVerticalBounce)

        authService.regularSignIn(email: email, password: password) { error in
            completion(error?.localizedDescription ?? "error")
            return
        }
        UniBookMiDatabase.shared.findUser(email: email) { [weak self] user, error in
            if let user {
                self?.authService.user = user
            } else {
                completion(error?.localizedDescription ?? "error")
            }
        }
        completion("")
        ProgressHUD.dismiss()
    }

    internal func register(email: String, password: String, name: String, completion: @escaping (String) -> Void){

        ProgressHUD.animate("", AnimationType.ballVerticalBounce)

        authService.regularCreateAccount(email: email, password: password) { [weak self] result, error in
            if let error {
                completion(error.localizedDescription)
            } else {
                Task {
                    await UniBookMiDatabase.shared.addUser(name: name, email: email)

                }
                self?.authService.user = UserModel(name: name, email: email)
            }

        }

        ProgressHUD.dismiss()

    }


}
