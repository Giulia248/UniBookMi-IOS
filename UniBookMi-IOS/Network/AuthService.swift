//
//  AuthService.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 09/04/24.
//


import Foundation
import FirebaseCore
import FirebaseAuth
import CryptoKit
import AuthenticationServices

final class AuthService: NSObject, ObservableObject, ASAuthorizationControllerDelegate  {

    @Published var signedIn: Bool = false
    @Published var user: UserModel?

    // Unhashed nonce.
    var currentNonce: String?

    override init() {
        super.init()
        Auth.auth().addStateDidChangeListener() { [weak self] auth, user in
            if user != nil {
                self?.signedIn = true
                UniBookMiDatabase.shared.findUser(email: user?.email ?? "") { user, error in
                    if let user {
                        self?.user = UserModel(name: user.name, email: user.email)
                    } else {
                        UniBookMiLog("NO USER FOUND \(error?.localizedDescription ?? "")")
                    }
                }
            } else {
                self?.signedIn = false
            }
        }
    }

    // MARK: - Password Account
    func regularCreateAccount(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {

                UniBookMiLog(e.localizedDescription)
                completion(nil, error)

            } else {
                if let result = authResult {
                    completion(result, nil)
                }
            }


        }
    }

    //MARK: - Traditional sign in
    // Traditional sign in with password and email
    func regularSignIn(email:String, password:String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            if let e = error {
                completion(e)
            } else {
                completion(nil)
            }
        }
    }

    // Regular password acount sign out.
    // Closure has whether sign out was successful or not
    func regularSignOut(completion: @escaping (Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {

            UniBookMiLog("Error signing out: %@ \(signOutError)")
            completion(signOutError)
        }
    }
}
