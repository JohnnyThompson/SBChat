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
  case cannotGetUserInfo
  case cannotUnwrapToMUser
}

extension UserError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .notField:
      return NSLocalizedString("Заполните все поля", comment: "")
    case .photoNotExist:
      return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
    case .cannotGetUserInfo:
      return NSLocalizedString("Невозможно загрузить информацию о пользователе из Firebase", comment: "")
    case .cannotUnwrapToMUser:
      return NSLocalizedString("Невозможно конвертировать в MUser из User", comment: "")
    }
  }
}
