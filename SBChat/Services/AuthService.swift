//
//  AuthService.swift
//  SBChat
//
//  Created by Евгений Карпов on 09.02.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthService {
  static let shared = AuthService()
  private init() {}
  private let auth = Auth.auth()
  func login(email: String?,
             password: String?,
             completion: @escaping (Result<User, Error>) -> Void) {
    guard let email = email,
          let password = password else {
            completion(.failure(AuthError.notField))
            return
          }
    auth.signIn(withEmail: email, password: password) { result, error in
      guard let result = result else {
        completion(.failure(error!))
        return
      }
      completion(.success(result.user))
    }
  }
  func googleLogin(presenting: UIViewController) {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.signIn(with: config, presenting: presenting) { [unowned presenting] user, error in
      if let error = error {
        presenting.showAlert(with: "Ошибка", and: error.localizedDescription)
        return
      }
      guard let authentication = user?.authentication,
            let idToken = authentication.idToken else {
              return
            }
      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: authentication.accessToken)
      Auth.auth().signIn(with: credential) { result, error in
        guard let result = result else {
          presenting.showAlert(with: "Ошибка", and: error?.localizedDescription ?? "Unknown error")
          return
        }
        FirestoreService.shared.getUserData(user: result.user) { res in
          switch res {
          case .success(let mUser):
            presenting.showAlert(with: "Успех", and: "Вы успешно вошли!") {
              let mainTabBar = MainTabBarController(currentUser: mUser)
              mainTabBar.modalPresentationStyle = .fullScreen
              presenting.present(mainTabBar, animated: true)
            }
          case .failure:
            presenting.showAlert(with: "Успех",
                                 and: "Вы зарегистрированы, настройте свой профиль!") {
              presenting.present(SetupProfileViewController(currentUser: result.user), animated: true)
            }
          }
        }
      }
    }
  }
  func register(email: String?,
                password: String?,
                confirmPassword: String?,
                completion: @escaping (Result<User, Error>) -> Void) {
    guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
      completion(.failure(AuthError.notField))
      return
    }
    guard password! == confirmPassword! else {
      completion(.failure(AuthError.passwordNotMatched))
      return
    }
    guard Validators.isSimpleEmail(email!) else {
      completion(.failure(AuthError.invalidEmail))
      return
    }
    auth.createUser(withEmail: email!, password: password!) { result, error in
      guard let result = result else {
        completion(.failure(error!))
        return
      }
      completion(.success(result.user))
    }
  }
}
