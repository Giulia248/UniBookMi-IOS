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

class AuthService: NSObject, ObservableObject, ASAuthorizationControllerDelegate  {

    @Published var signedIn: Bool = false

    // Unhashed nonce.
    var currentNonce: String?

    override init() {
        super.init()
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.signedIn = true
            } else {
                self.signedIn = false
            }
        }
    }

    // MARK: - Password Account
    func regularCreateAccount(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {

                print(e.localizedDescription)
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
          print("Error signing out: %@", signOutError)
          completion(signOutError)
        }
    }
}
