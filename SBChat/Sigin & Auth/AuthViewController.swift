//
//  ViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 03.12.2021.
//

import UIKit

class AuthViewController: UIViewController {
  // MARK: - Properties
  let logoImageView = UIImageView(
    image: #imageLiteral(resourceName: "Logo"),
    contentMode: .scaleAspectFit)
  let googleLabel = UILabel(
    text: "Get started wit")
  let emailLabel = UILabel(
    text: "Or sign up with")
  let alreadyOnboardLabel = UILabel(
    text: "Already onboard?")
  let googleButton = UIButton(
    title: "Google",
    titleColor: .black,
    backgroundColor: .white,
    isShadow: true)
  let emailButton = UIButton(
    title: "Email",
    titleColor: .white,
    backgroundColor: .buttonDark())
  let loginButton = UIButton(
    title: "Login",
    titleColor: .buttonRed(),
    backgroundColor: .white,
    isShadow: true)
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupConstraints()
    googleButton.costomizeGoogleButton()
  }
}

// MARK: - SetupConstraints
extension AuthViewController {
  private func setupConstraints() {
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    let googleView = ButtonFormView(label: googleLabel, button: googleButton)
    let emailView = ButtonFormView(label: emailLabel, button: emailButton)
    let loginView = ButtonFormView(label: alreadyOnboardLabel, button: loginButton)
    let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: 40)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(logoImageView)
    view.addSubview(stackView)
    NSLayoutConstraint.activate([
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160)
    ])
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
    ])
  }
}

// MARK: - SwiftUI
import SwiftUI
struct AuthViewControllerProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  struct ContainerView: UIViewControllerRepresentable {
    let viewController = AuthViewController()
    func makeUIViewController(context: Context) -> some UIViewController {
      return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  }
}
