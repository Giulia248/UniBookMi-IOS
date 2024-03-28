//
//  LoginViewModel.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 28/03/24.
//

import Foundation

final class LoginViewModel: ObservableObject {

    internal func isLoginEnabled(email: String, password: String) -> Bool{

        let firstLevelDomani = (email.contains(".com") || email.contains(".it"))
        return !((!(email.isEmpty) && !(password.isEmpty) && email.contains("@") && firstLevelDomani))
    }

}
