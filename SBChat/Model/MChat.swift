//
//  MChat.swift
//  SBChat
//
//  Created by Евгений Карпов on 02.01.2022.
//

import Foundation

struct MChat: Hashable, Decodable {
  var username: String
  var userImageString: String
  var lastMessage: String
  var id: Int  
  static func == (lhs: MChat, rhs: MChat) -> Bool {
    return lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
