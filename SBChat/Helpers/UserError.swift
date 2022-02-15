//
//  UserError.swift
//  SBChat
//
//  Created by Евгений Карпов on 15.02.2022.
//

import Foundation

enum UserError: Error {
  case notField
  case photoNotExist
}

extension UserError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .notField:
      return NSLocalizedString("Заполните все поля", comment: "")
    case .photoNotExist:
      return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
    }
  }
}
