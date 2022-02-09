//
//  ChatRequestViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 09.02.2022.
//

import UIKit

class ChatRequestViewController: UIViewController {
  // MARK: - Properties
  let containerView = UIView()
  let imageView = UIImageView(image: #imageLiteral(resourceName: "human3"), contentMode: .scaleAspectFill)
  let nameLabel = UILabel(text: "Peter Ben", font: .systemFont(ofSize: 20, weight: .light))
  let aboutMeLabel = UILabel(text: "You have opportunity to start a new chat!",
                             font: .systemFont(ofSize: 16, weight: .light))
  let acceptButton = UIButton(title: "ACCEPT",
                              titleColor: .white,
                              backgroundColor: .black,
                              font: .laoSangamMN20(),
                              isShadow: false,
                              cornerRadius: 10)
  let denyButton = UIButton(title: "DENY",
                            titleColor: #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1),
                            backgroundColor: .mainWhite(),
                            font: .laoSangamMN20(),
                            isShadow: false,
                            cornerRadius: 10)
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .mainWhite()
    customisingElements()
    setupConstraints()
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.acceptButton.applyGradients(cornerRadius: 10)
  }
  // MARK: - Module functions
  private func customisingElements() {
    denyButton.layer.borderWidth = 1.2
    denyButton.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
    aboutMeLabel.numberOfLines = 1
    containerView.backgroundColor = .mainWhite()
    containerView.layer.cornerRadius = 30
  }
}
// MARK: - Setup contraints
extension ChatRequestViewController {
  func setupConstraints() {
    view.addSubview(imageView)
    view.addSubview(containerView)
    containerView.addSubview(nameLabel)
    containerView.addSubview(aboutMeLabel)
    let buttonStackView = UIStackView(arrangedSubviews: [acceptButton, denyButton],
                                      axis: .horizontal,
                                      spacing: 7)
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    buttonStackView.distribution = .fillEqually
    containerView.addSubview(buttonStackView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
    ])
    NSLayoutConstraint.activate([
      containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      containerView.heightAnchor.constraint(equalToConstant: 206)
    ])
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
      nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
      nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
    ])
    NSLayoutConstraint.activate([
      aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
      aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
      aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
    ])
    NSLayoutConstraint.activate([
      buttonStackView.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 24),
      buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
      buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
      buttonStackView.heightAnchor.constraint(equalToConstant: 56)
    ])
  }
}
// MARK: - SwiftUI
import SwiftUI

struct ChatRequestViewControllerProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  struct ContainerView: UIViewControllerRepresentable {
    let tabBarVC = ChatRequestViewController()
    func makeUIViewController(context: Context) -> some UIViewController {
      return tabBarVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  }
}
