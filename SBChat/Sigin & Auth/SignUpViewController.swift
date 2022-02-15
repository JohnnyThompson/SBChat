//
//  SignUpViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 03.12.2021.
//

import UIKit

class SignUpViewController: UIViewController {
  // MARK: - Properties
  let welcomeLabel = UILabel(text: "Good to see you", font: .avenir26())
  let emailLabel = UILabel(text: "Email")
  let passwordLabel = UILabel(text: "Password")
  let confirmPasswordLabel = UILabel(text: "Confirm password")
  let alreadyOnboardLabel = UILabel(text: "Already onboard?")
  let signUpButton = UIButton(title: "Sign up",
                              titleColor: .white,
                              backgroundColor: .buttonDark())
  let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Login", for: .normal)
    button.setTitleColor(.buttonRed(), for: .normal)
    button.titleLabel?.font = .avenir20()
    return button
  }()
  let emailTextField = OneLineTextField(font: .avenir20())
  let passwordTextField = OneLineTextField(font: .avenir20())
  let confirmPasswordTextField = OneLineTextField(font: .avenir20())
  weak var delegate: AuthNavigationDelegate?
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupConstraints()
    signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
  }
  // MARK: - Module functions
  @objc private func signUpButtonTapped() {
    print(#function)
    AuthService.shared.register(email: emailTextField.text,
                                password: passwordTextField.text,
                                confirmPassword: confirmPasswordTextField.text) { result in
      switch result {
      case .success(let user):
        self.showAlert(with: "Success!", and: "You will be registered") {
          self.present(SetupProfileViewController(currentUser: user), animated: true)
        }
        print(user.email!)
      case .failure(let error):
        self.showAlert(with: "Failure!", and: error.localizedDescription)
      }
    }
  }
  @objc private func loginButtonTapped() {
    dismiss(animated: true) { [unowned self] in
      delegate?.toLoginVC()
    }
  }
}
// MARK: - SetupConstraints
extension SignUpViewController {
  private func setupConstraints() {
    let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField],
                                     axis: .vertical,
                                     spacing: 0)
    let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField],
                                        axis: .vertical,
                                        spacing: 0)
    let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField],
                                               axis: .vertical,
                                               spacing: 0)
    signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    let stackView = UIStackView(arrangedSubviews: [
      emailStackView,
      passwordStackView,
      confirmPasswordStackView,
      signUpButton],
                                axis: .vertical,
                                spacing: 40)
    loginButton.contentHorizontalAlignment = .leading
    let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton],
                                      axis: .horizontal,
                                      spacing: 10)
    bottomStackView.alignment = .firstBaseline
    welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(welcomeLabel)
    view.addSubview(stackView)
    view.addSubview(bottomStackView)
    NSLayoutConstraint.activate([
      welcomeLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 160),
      welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
    ])
    NSLayoutConstraint.activate([
      bottomStackView.topAnchor.constraint(lessThanOrEqualTo: stackView.bottomAnchor, constant: 80),
      bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      bottomStackView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -40)
    ])
  }
}

// MARK: - SwiftUI
import SwiftUI

struct SignUpViewControllerProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  struct ContainerView: UIViewControllerRepresentable {
    let signUpVC = SignUpViewController()
    func makeUIViewController(context: Context) -> some UIViewController {
      return signUpVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  }
}
