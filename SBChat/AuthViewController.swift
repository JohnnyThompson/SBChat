//
//  ViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 03.12.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(
        image: #imageLiteral(resourceName: "Logo"),
        contentMode: .scaleAspectFit)
    
    let googleLabel = UILabel(
        text: "Get started wit")
    let emailLabel = UILabel(
        text: "Or sign up with")
    let alreadyOnBoardLabel = UILabel(
        text: "Already onboard?")
    
    let googleButton = UIButton(
        title: "Google",
        titleColor: .white,
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
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints()  {
        view.addSubview(logoImageView)
        
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
