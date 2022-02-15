//
//  FirestoreService.swift
//  SBChat
//
//  Created by Евгений Карпов on 15.02.2022.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
  static let shared = FirestoreService()
  let db  = Firestore.firestore()
  private var userRef: CollectionReference {
    return db.collection("users")
  }
  private init() { }

  func saveProfileWith(id: String,
                       email: String,
                       username: String?,
                       avatarImageString: String?,
                       description: String?,
                       sex: String?,
                       completion: @escaping (Result<MUser, Error>) -> Void) {
    guard Validators.isFilled(username: username, description: description, sex: sex) else {
      completion(.failure(UserError.notField))
      return
    }
    let mUser = MUser(username: username!,
                      id: id,
                      email: email,
                      description: description!,
                      sex: sex!,
                      avatarStringURL: "not exist")
    self.userRef.document(mUser.id).setData(mUser.representation) { error in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(mUser))
      }
    }
  }
}
