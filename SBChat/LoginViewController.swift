//
//  LoginViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 05.12.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    let welcomLabel = UILabel(text: "Welcome Back!", font: .avenir26())
   
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountLabel = UILabel(text: "Need an account?")
    
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20()) 
    
    let googleButton = UIButton(
        title: "Google",
        titleColor: .black,
        backgroundColor: .white,
        isShadow: true)
    let loginButton = UIButton(
        title: "Login",
        titleColor: .white,
        backgroundColor: .buttonDark())
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        googleButton.costomizeGoogleButton()
    }
}

// MARK: - Setup Constraints

extension LoginViewController {
    private func setupConstraints() {
        let loginWithView  = ButtonFormView(
            label: loginWithLabel,
            button: googleButton)
        let emailStackView = UIStackView(
            arrangedSubviews: [emailLabel,emailTextField],
            axis: .vertical,
            spacing: 0)
        let passwordStackView = UIStackView(
            arrangedSubviews: [passwordLabel, passwordTextField],
            axis: .vertical,
            spacing: 0)
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(
            arrangedSubviews: [
                loginWithView,
                emailStackView,
                passwordStackView,
                loginButton],
            axis: .vertical,
            spacing: 40)
        
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(
            arrangedSubviews: [needAnAccountLabel, signUpButton],
            axis: .horizontal,
            spacing: 20)
        bottomStackView.alignment = .firstBaseline
        
        welcomLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 160),
            welcomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo:welcomLabel.bottomAnchor,
                constant: 60),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 40),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: 60),
            bottomStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 40),
            bottomStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -40)
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

