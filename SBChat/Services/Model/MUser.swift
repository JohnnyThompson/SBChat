//
//  MUser.swift
//  SBChat
//
//  Created by Евгений Карпов on 02.01.2022.
//

import Foundation

struct MUser: Hashable, Decodable {
  var username: String
  var id: String
  var email: String
  var description: String
  var sex: String
  var avatarStringURL: String
  var representation: [String: Any] {
    var rep = ["username" : username]
    rep["sex"] = sex
    rep["uid"] = id
    rep["email"] = email
    rep["description"] = description
    rep["avatarStringURL"] = avatarStringURL
    return rep
  }
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
