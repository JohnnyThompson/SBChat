//
//  AuthNavigationDelegate.swift
//  SBChat
//
//  Created by Евгений Карпов on 15.02.2022.
//

import Foundation

protocol AuthNavigationDelegate: AnyObject {
  func toLoginVC()
  func toSignUpVC()
}
