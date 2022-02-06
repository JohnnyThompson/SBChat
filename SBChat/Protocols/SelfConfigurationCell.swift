//
//  SelfConfigurationCell.swift
//  SBChat
//
//  Created by Евгений Карпов on 26.12.2021.
//

import Foundation

protocol SelfConfiguringCell {
  static var reuseID: String {get}
  func configure<U: Hashable>(with value: U)
}
