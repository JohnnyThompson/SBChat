//
//  SetupProfileViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 05.12.2021.
//

import UIKit
import FirebaseAuth

class SetupProfileViewController: UIViewController {
  // MARK: - Properties
  let fillImageView = AddPhotoView()
  let setupProfileLabel = UILabel(text: "Set up profile", font: .avenir26())
  let fullNameLabel = UILabel(text: "Full Name")
  let aboutMeLabel = UILabel(text: "About Me")
  let sexLabel = UILabel(text: "Sex")
  let fullNameTextField = OneLineTextField(font: .avenir20())
  let aboutMeTextField = OneLineTextField(font: .avenir20())
  let goToChatsButton = UIButton(
    title: "Go to chats!",
    titleColor: .white,
    backgroundColor: .buttonDark())
  let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
  private let currentUser: User

  init(currentUser: User) {
    self.currentUser = currentUser
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupConstrains()
    goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
  }
  @objc private func goToChatsButtonTapped() {
    FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                            email: currentUser.email!,
                                            username: fullNameTextField.text,
                                            avatarImageString: "nil",
                                            description: aboutMeTextField.text,
                                            sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { result in
      switch result {
      case .success(let mUser):
        self.showAlert(with: "Success!", and: "Auth success")
        print(mUser)
      case .failure(let error):
        self.showAlert(with: "Failure!", and: error.localizedDescription)
      }
    }
  }
}

// MARK: - Setup Constrains
extension SetupProfileViewController {
  private func setupConstrains() {
    let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField],
                                        axis: .vertical,
                                        spacing: 0)
    let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField],
                                       axis: .vertical,
                                       spacing: 0)
    let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl],
                                   axis: .vertical,
                                   spacing: 10)
    goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    let stackView = UIStackView(arrangedSubviews: [fullNameStackView,
                                                   aboutMeStackView,
                                                   sexStackView,
                                                   goToChatsButton],
                                axis: .vertical,
                                spacing: 40)
    setupProfileLabel.translatesAutoresizingMaskIntoConstraints = false
    fillImageView.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(setupProfileLabel)
    view.addSubview(fillImageView)
    view.addSubview(stackView)
    NSLayoutConstraint.activate([
      setupProfileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
      setupProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    NSLayoutConstraint.activate([
      fillImageView.topAnchor.constraint(equalTo: setupProfileLabel.bottomAnchor,
                                         constant: 40),
      fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 40),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
    ])
  }
}

// MARK: - SwiftUI
import SwiftUI

struct SetupProfileControllerProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  struct ContainerView: UIViewControllerRepresentable {
    let setupProfileVC = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
    func makeUIViewController(context: Context) -> some UIViewController {
      return setupProfileVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  }
}
