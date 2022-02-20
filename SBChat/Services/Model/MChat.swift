//
//  MChat.swift
//  SBChat
//
//  Created by Евгений Карпов on 02.01.2022.
//

import Foundation

struct MChat: Hashable, Decodable {
  var friendUsername: String
  var friendUserImageString: String
  var lastMessageContent: String
  var friendID: String
  static func == (lhs: MChat, rhs: MChat) -> Bool {
    return lhs.friendID == rhs.friendID
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(friendID)
  }
}
