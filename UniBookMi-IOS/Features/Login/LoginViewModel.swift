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

        authService.regularSignIn(email: email, password: password) { error in
            completion(error?.localizedDescription ?? "error")
            return
        }
        completion("")
    }

    internal func register(email: String, password: String, name: String, completion: @escaping (String) -> Void){

        authService.regularCreateAccount(email: email, password: password) { result, error in
            if let result {
                Task {
                    await UniBookMiDatabase.shared.addUser(name: name, id: result.user.uid)
                }
            } else {
                completion(error?.localizedDescription ?? "error")
            }

        }

    }


}
