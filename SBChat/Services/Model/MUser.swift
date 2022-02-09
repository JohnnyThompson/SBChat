//
//  MUser.swift
//  SBChat
//
//  Created by Евгений Карпов on 02.01.2022.
//

import Foundation

struct MUser: Hashable, Decodable {
  var username: String
  var avatarStringURL: String
  var id: Int
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