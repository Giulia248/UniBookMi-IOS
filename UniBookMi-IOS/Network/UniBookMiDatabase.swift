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


    internal func addUser(name: String, id: String) async {

        do {
          let ref = try await dataBase.collection("users").addDocument(data: [
            "name": name,
            "id": id
          ])
          print("Document added with ID: \(ref.documentID)")
        } catch {
          print("Error adding document: \(error)")
        }
    }

}
