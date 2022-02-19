//
//  UserCell.swift
//  SBChat
//
//  Created by Евгений Карпов on 06.02.2022.
//

import UIKit
import SDWebImage

class UserCell: UICollectionViewCell, SelfConfiguringCell {
  // MARK: - Properties
  static var reuseID: String = "UserCell"
  let userImageView = UIImageView()
  let userName = UILabel(text: "text", font: .laoSangamMN20())
  let containerView = UIView()

  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    setupConstraints()
    self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
    self.layer.shadowRadius = 3
    self.layer.shadowOpacity = 0.5
    self.layer.shadowOffset = CGSize(width: 0, height: 4)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    self.containerView.layer.cornerRadius = 4
    self.containerView.clipsToBounds = true
  }

  override func prepareForReuse() {
    userImageView.image = nil
  }

  // MARK: - Public functions
  func configure<U: Hashable>(with value: U) {
    guard let user = value as? MUser else {
      return
    }
    userName.text = user.username
    guard let url = URL(string: user.avatarStringURL) else {
      return
    }
    userImageView.sd_setImage(with: url, completed: nil)
  }
}

extension UserCell {
  // MARK: - Module functions
  private func setupConstraints() {
    userImageView.translatesAutoresizingMaskIntoConstraints = false
    userName.translatesAutoresizingMaskIntoConstraints = false
    containerView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(containerView)
    containerView.addSubview(userImageView)
    containerView.addSubview(userName)
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: self.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
    NSLayoutConstraint.activate([
      userImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      userImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      userImageView.heightAnchor.constraint(equalTo: self.widthAnchor)
    ])
    NSLayoutConstraint.activate([
      userName.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
      userName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
      userName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
      userName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
  }
}

// MARK: - SwiftUI
import SwiftUI

struct UserChatProvider: PreviewProvider {
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
