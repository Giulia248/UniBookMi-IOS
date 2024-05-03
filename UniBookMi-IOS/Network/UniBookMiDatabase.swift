//
//  UniBookMiDatabase.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 09/04/24.
//

import Foundation
import FirebaseFirestore

final class UniBookMiDatabase {

    static let shared = UniBookMiDatabase()
    private let dataBase = Firestore.firestore()


    internal func addUser(name: String, email: String) async {

        do {
            let ref = try await dataBase.collection("users").addDocument(data: [
                "name": name,
                "email": email
            ])
            UniBookMiLog("Document added with ID: \(ref.documentID)")
        } catch {
            UniBookMiLog("Error adding document: \(error)")
        }
    }

    internal func findUser(email: String, completion: @escaping (UserModel?, Error?) -> Void ) {
        self.dataBase.collection("users").whereField("email", isEqualTo: email).getDocuments { (snapshot, err) in
            if let err = err {
                completion(nil, err)
            } else {
                for document in snapshot?.documents ?? []{
                    let user = UserModel(name: document.get("name") as? String, email: document.get("email") as? String)
                    completion(user, nil)
                }
            }
        }

    }
}
