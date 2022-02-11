//
//  AuthError.swift
//  SBChat
//
//  Created by Евгений Карпов on 11.02.2022.
//

import Foundation

enum AuthError: Error {
  case notField
  case invalidEmail
  case passwordNotMatched
  case unknownError
  case serverError
}

extension AuthError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .notField:
      return NSLocalizedString("Заполните все поля", comment: "")
    case .invalidEmail:
      return NSLocalizedString("Формат почты не является допустимым", comment: "")
    case .passwordNotMatched:
      return NSLocalizedString("Пароли не совпадают", comment: "")
    case .unknownError:
      return NSLocalizedString("Неизвестная ошибка", comment: "")
    case .serverError:
      return NSLocalizedString("Ошибка сервера", comment: "")
    }
  }
}
