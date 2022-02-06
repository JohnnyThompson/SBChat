//
//  ActiveChatCell.swift
//  SBChat
//
//  Created by Евгений Карпов on 11.12.2021.
//

import UIKit


class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {
  // MARK: - Properties
  static var reuseID: String = "ActiveChatCell"
  
  let friendImageView = UIImageView()
  let friendName = UILabel(text: "User name", font: .laoSangamMN20())
  let lastMessage = UILabel(text: "How are u?", font: .laoSangamMN18())
  let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstrains()
    self.backgroundColor = .white
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure<U: Hashable>(with value: U) {
    guard let value = value as? MChat else {
      return
    }
    friendImageView.image = UIImage(named: value.userImageString)
    friendName.text = value.username
    lastMessage.text = value.lastMessage
  }
}

// MARK: - Setup constrains

extension ActiveChatCell {
  private func setupConstrains() {
    friendImageView.translatesAutoresizingMaskIntoConstraints = false
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    friendName.translatesAutoresizingMaskIntoConstraints = false
    lastMessage.translatesAutoresizingMaskIntoConstraints = false
    
    friendImageView.backgroundColor = .red
    gradientView.backgroundColor = .black
    
    addSubview(friendImageView)
    addSubview(gradientView)
    addSubview(friendName)
    addSubview(lastMessage)
    
    //friendImageView Constraints
    NSLayoutConstraint.activate([
      friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      friendImageView.heightAnchor.constraint(equalToConstant: 78),
      friendImageView.widthAnchor.constraint(equalToConstant: 78)
    ])
    
    //gradientImageView Constraints
    NSLayoutConstraint.activate([
      gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      gradientView.heightAnchor.constraint(equalToConstant: 78),
      gradientView.widthAnchor.constraint(equalToConstant: 8)
    ])
    
    //friendName Constraints
    NSLayoutConstraint.activate([
      friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
      friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
      friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16),
    ])
    
    //lasMessage Constrains
    NSLayoutConstraint.activate([
      lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
      lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
      lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16),
    ])
  }
}

// MARK: - SwiftUI

import SwiftUI

struct ActiveChatProvider: PreviewProvider {
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

