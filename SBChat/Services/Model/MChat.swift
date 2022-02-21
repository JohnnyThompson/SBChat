//
//  MChat.swift
//  SBChat
//
//  Created by Евгений Карпов on 02.01.2022.
//

import Foundation

struct MChat: Hashable, Decodable {
  var friendUsername: String
  var friendUserImageStringURL: String
  var lastMessageContent: String
  var friendID: String
  var representation: [String: Any] {
    let rep: [String: Any] = ["friendUsername": friendUsername,
               "friendUserImageStringURL": friendUserImageStringURL,
               "lastMessage": lastMessageContent,
               "friendID": friendID
    ]
    return rep
  }
  static func == (lhs: MChat, rhs: MChat) -> Bool {
    return lhs.friendID == rhs.friendID
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(friendID)
  }
}
