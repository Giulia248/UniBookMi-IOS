//
//  LoginViewModel.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 28/03/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

final class LoginViewModel: ObservableObject {


    internal func isLoginEnabled(email: String, password: String) -> Bool{
        return !(email.isEmpty) && !(password.isEmpty) && email.contains("@") && email.contains("unimi.it")
    }


}
