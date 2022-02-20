//
//  ListenerService.swift
//  SBChat
//
//  Created by Евгений Карпов on 19.02.2022.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class ListenerService {
  static let shared = ListenerService()
  private let database = Firestore.firestore()
  private var userRef: CollectionReference {
    return database.collection("users")
  }
  private var currentUserId: String {
    return Auth.auth().currentUser!.uid
  }
  
  func usersObserve(
    users: [MUser],
    completion: @escaping (Result<[MUser], Error>) -> Void
  ) -> ListenerRegistration? {
    var users = users
    let userListener = userRef.addSnapshotListener { querySnapshot, error in
      guard let snapshot = querySnapshot else {
        completion(.failure(error!))
        return
      }
      snapshot.documentChanges(includeMetadataChanges: false).forEach { diff in
        guard let muser = MUser(document: diff.document) else {
          return
        }
        switch diff.type {
        case .added:
          guard !users.contains(muser),
                muser.id != self.currentUserId else { return }
          users.append(muser)
        case .modified:
          guard let index = users.firstIndex(of: muser) else { return }
          users[index] = muser
        case .removed:
          guard let index = users.firstIndex(of: muser) else { return }
          users.remove(at: index)
        }
      }
      completion(.success(users))
    }
    return userListener
  }
}
