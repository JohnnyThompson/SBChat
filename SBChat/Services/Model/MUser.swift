//
//  MUser.swift
//  SBChat
//
//  Created by Евгений Карпов on 02.01.2022.
//

import Foundation
import FirebaseFirestore

struct MUser: Hashable, Decodable {
  // MARK: - Properties
  var username: String
  var id: String
  var email: String
  var description: String
  var sex: String
  var avatarStringURL: String
  var representation: [String: Any] {
    var rep = ["username": username]
    rep["sex"] = sex
    rep["uid"] = id
    rep["email"] = email
    rep["description"] = description
    rep["avatarStringURL"] = avatarStringURL
    return rep
  }
  // MARK: - Initialization
  init(username: String,
       id: String,
       email: String,
       description: String,
       sex: String,
       avatarStringURL: String) {
    self.username = username
    self.id = id
    self.email = email
    self.description = description
    self.sex = sex
    self.avatarStringURL =  avatarStringURL
  }
  init?(document: DocumentSnapshot) {
    guard let data = document.data(),
          let username = data["username"] as? String,
          let id = data["uid"] as? String,
          let email = data["email"] as? String,
          let avatarStringURL = data["avatarStringURL"] as? String,
          let sex = data["sex"] as? String,
          let description = data["description"] as? String else {
      return nil
    }
    self.username = username
    self.id = id
    self.email = email
    self.avatarStringURL = avatarStringURL
    self.sex = sex
    self.description = description
  }
  init?(document: QueryDocumentSnapshot) {
    let data = document.data()
    guard let username = data["username"] as? String,
          let id = data["uid"] as? String,
          let email = data["email"] as? String,
          let avatarStringURL = data["avatarStringURL"] as? String,
          let sex = data["sex"] as? String,
          let description = data["description"] as? String else {
      return nil
    }
    self.username = username
    self.id = id
    self.email = email
    self.avatarStringURL = avatarStringURL
    self.sex = sex
    self.description = description
  }
  // MARK: - Functions
  static func == (lhs: MUser, rhs: MUser) -> Bool {
    return lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  func contains(filter: String?) -> Bool {
    guard let filter = filter, !filter.isEmpty else {
      return true
    }
    let lowercasedFilter = filter.lowercased()
    return username.lowercased().contains(lowercasedFilter)
  }
}
