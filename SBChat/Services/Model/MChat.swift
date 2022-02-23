//
//  MChat.swift
//  SBChat
//
//  Created by Евгений Карпов on 02.01.2022.
//

import Foundation
import FirebaseFirestore

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
  init(
    friendUsername: String,
    friendUserImageStringURL: String,
    lastMessageContent: String,
    friendID: String) {
      self.friendUsername = friendUsername
      self.friendUserImageStringURL = friendUserImageStringURL
      self.lastMessageContent = lastMessageContent
      self.friendID = friendID
    }
  init?(document: QueryDocumentSnapshot) {
    let data = document.data()
    guard let friendUsername = data["friendUsername"] as? String,
          let friendUserImageStringURL = data["friendUserImageStringURL"] as? String,
          let lastMessageContent = data["lastMessage"] as? String,
          let friendID = data["friendID"] as? String else {
            return nil
          }
    self.friendUsername = friendUsername
    self.friendUserImageStringURL = friendUserImageStringURL
    self.lastMessageContent = lastMessageContent
    self.friendID = friendID
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(friendID)
  }
}
