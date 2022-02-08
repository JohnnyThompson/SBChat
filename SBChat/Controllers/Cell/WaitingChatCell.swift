//
//  WaitingChatCell.swift
//  SBChat
//
//  Created by Евгений Карпов on 26.12.2021.
//

import UIKit

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
  // MARK: - Properties
  static var reuseID: String = "WaitingChatCell"
  let friendImageView = UIImageView()

  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .yellow
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
    setupConstraints()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Public function
  func configure<U: Hashable>(with value: U) {
    guard let value = value as? MChat else {
      return
    }
    friendImageView.image = UIImage(named: value.userImageString)
  }
  // MARK: - Module function
  private func setupConstraints() {
    friendImageView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(friendImageView)
    NSLayoutConstraint.activate([
      friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
      friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}

// MARK: - SwiftUI
import SwiftUI

struct WaitingViewControllerProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  struct ContainerView: UIViewControllerRepresentable {
    let tabBarVC = MainTabBarController()
    func makeUIViewController(context: Context) -> some UIViewController {
      return tabBarVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  }
}
