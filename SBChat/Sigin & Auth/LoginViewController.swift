//
//  LoginViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 05.12.2021.
//

import UIKit

class LoginViewController: UIViewController {

  // MARK: - Properties
  let welcomeLabel = UILabel(text: "Welcome Back!", font: .avenir26())
  let loginWithLabel = UILabel(text: "Login with")
  let orLabel = UILabel(text: "or")
  let emailLabel = UILabel(text: "Email")
  let passwordLabel = UILabel(text: "Password")
  let needAnAccountLabel = UILabel(text: "Need an account?")
  let emailTextField = OneLineTextField(font: .avenir20())
  let passwordTextField = OneLineTextField(font: .avenir20())
  let googleButton = UIButton(title: "Google",
                              titleColor: .black,
                              backgroundColor: .white,
                              isShadow: true)
  let loginButton = UIButton(title: "Login",
                             titleColor: .white,
                             backgroundColor: .buttonDark())
  let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign up", for: .normal)
    button.setTitleColor(.buttonRed(), for: .normal)
    button.titleLabel?.font = .avenir20()
    return button
  }()
  weak var delegate: AuthNavigationDelegate?
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupConstraints()
    googleButton.costomizeGoogleButton()
    loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
  }
  // MARK: - Module functions
  @objc private func loginButtonTapped() {
    AuthService.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { result in
      switch result {
      case .success(let user):
        self.showAlert(with: "Успех!", and: "Авторизация выполнена") {
          FirestoreService.shared.getUserData(user: user) { result in
            switch result {
            case .success(let mUser):
              let mainTabBar = MainTabBarController(currentUser: mUser)
              mainTabBar.modalPresentationStyle = .fullScreen
              self.present(mainTabBar, animated: true)
            case .failure:
              self.present(SetupProfileViewController(currentUser: user), animated: true)
            }
          }
        }
        print(user.email!)
      case .failure(let error):
        self.showAlert(with: "Failure!", and: error.localizedDescription)
      }
    }
  }
  @objc private func signUpButtonTapped() {
    dismiss(animated: true) { [unowned self] in
      delegate?.toSignUpVC()
    }
  }
  @objc private func googleButtonTapped() {
    AuthService.shared.googleLogin(presenting: self)
  }
}

// MARK: - Setup Constraints

extension LoginViewController {
  private func setupConstraints() {
    let loginWithView  = ButtonFormView(label: loginWithLabel,
                                        button: googleButton)
    let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField],
                                     axis: .vertical,
                                     spacing: 0)
    let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField],
                                        axis: .vertical,
                                        spacing: 0)
    loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    let stackView = UIStackView(arrangedSubviews: [loginWithView,
                                                   emailStackView,
                                                   passwordStackView,
                                                   loginButton],
                                axis: .vertical,
                                spacing: 40)
    signUpButton.contentHorizontalAlignment = .leading
    let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton],
                                      axis: .horizontal,
                                      spacing: 20)
    bottomStackView.alignment = .firstBaseline
    welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(welcomeLabel)
    view.addSubview(stackView)
    view.addSubview(bottomStackView)
    NSLayoutConstraint.activate([
      welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
      welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
    ])
    NSLayoutConstraint.activate([
      bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
      bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
    ])
  }
}

// MARK: - SwiftUI
import SwiftUI

struct LoginViewControllerProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  struct ContainerView: UIViewControllerRepresentable {
    let loginVC = LoginViewController()
    func makeUIViewController(context: Context) -> some UIViewController {
      return loginVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  }
}
