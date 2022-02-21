//
//  MMessage.swift
//  SBChat
//
//  Created by Евгений Карпов on 21.02.2022.
//

import Foundation

struct MMessage: Hashable {
  let content: String
  let senderID: String
  let senderUserName: String
  let sentDate: Date
  let id: String?
  var representation: [String: Any] {
    let rep: [String: Any] = [
      "created": sentDate,
      "senderID": senderID,
      "senderUserName": senderUserName,
      "content": content
    ]
    return rep
  }
  init(user: MUser, content: String) {
    self.content = content
    senderID = user.id
    senderUserName = user.username
    sentDate = Date()
    id = nil
  }
  static func == (lhs: MMessage, rhs: MMessage) -> Bool {
    lhs.senderID == rhs.senderID
  }
}
