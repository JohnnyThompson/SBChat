//
//  SignUpViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 03.12.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let welcomLabel = UILabel(text: "Good to see you", font: .avenir26())
    
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPasswordLabel = UILabel(text: "Confirm password")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    let signUpButton = UIButton(title: "Sign up", titleColor: .white, backgroundColor: .buttonDark())
    let loginButton = UIButton()
    
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    let confirmPasswordTextField = OneLineTextField(font: .avenir20())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.buttonRed(), for: .normal)
        loginButton.titleLabel?.font = .avenir20()
        view.backgroundColor = .white
        setupConstraints()
    }
}

// MARK: - SetupConstraints

extension SignUpViewController {
    private func setupConstraints() {
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField], axis: .vertical, spacing: 0)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(
            arrangedSubviews: [
                emailStackView,
                passwordStackView,
                confirmPasswordStackView,
                signUpButton],
            axis: .vertical,
            spacing: 40)
        
        let buttonStackView = UIStackView(
            arrangedSubviews: [
                alreadyOnboardLabel,
                loginButton],
            axis: .horizontal,
            spacing: -1)
        
        welcomLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomLabel)
        view.addSubview(stackView)
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            welcomLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 80),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -110)
            
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

