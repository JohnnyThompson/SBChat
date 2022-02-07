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
}
