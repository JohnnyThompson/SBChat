//
//  FirestoreService.swift
//  SBChat
//
//  Created by Евгений Карпов on 15.02.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit

class FirestoreService {
  static let shared = FirestoreService()
  let dataBase  = Firestore.firestore()
  private var userRef: CollectionReference {
    return dataBase.collection("users")
  }
  private init() { }
  func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
    let docRef = userRef.document(user.uid)
    docRef.getDocument { document, _ in
      if let document = document, document.exists {
        guard let mUser = MUser(document: document) else {
          completion(.failure(UserError.cannotUnwrapToMUser))
          return
        }
        completion(.success(mUser))
      } else {
        completion(.failure(UserError.cannotGetUserInfo))
      }
    }
  }
  func saveProfileWith(id: String,
                       email: String,
                       username: String?,
                       avatarImage: UIImage?,
                       description: String?,
                       sex: String?,
                       completion: @escaping (Result<MUser, Error>) -> Void) {
    guard Validators.isFilled(username: username, description: description, sex: sex) else {
      completion(.failure(UserError.notField))
      return
    }
    guard avatarImage != #imageLiteral(resourceName: "avatar") else {
      completion(.failure(UserError.photoNotExist))
      return
    }
    var mUser = MUser(username: username!,
                      id: id,
                      email: email,
                      description: description!,
                      sex: sex!,
                      avatarStringURL: "not exist")
    StorageService.shared.upload(photo: avatarImage!) { result in
      switch result {
      case .success(let url):
        mUser.avatarStringURL = url.absoluteString
        self.userRef.document(mUser.id).setData(mUser.representation) { error in
          if let error = error {
            completion(.failure(error))
          } else {
            completion(.success(mUser))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    } // StorageService
  } // saveProfileWith
}
