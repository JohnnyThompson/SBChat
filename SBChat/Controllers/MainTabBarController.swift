//
//  MainTabBarController.swift
//  SBChat
//
//  Created by Евгений Карпов on 05.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
  // MARK: - Properties
  private let currentUser: MUser
  // MARK: - Initialization
  init(currentUser: MUser = MUser(username: "Santo",
                                  id: "Lucia",
                                  email: "zakzak@mail.ru",
                                  description: "asd",
                                  sex: "male",
                                  avatarStringURL: "1")) {
    self.currentUser = currentUser
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.tintColor = #colorLiteral(red: 0.5568627451, green: 0.3529411765, blue: 0.968627451, alpha: 1)
    let listViewController = ListViewController(currentUser: currentUser)
    let peopleViewController = PeopleViewController(currentUser: currentUser)
    let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)!
    let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfiguration)!
    viewControllers = [
      generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
      generateNavigationController(rootViewController: listViewController, title: "Conversation", image: convImage)
    ]
  }
  // MARK: - Module functions
  private func generateNavigationController(rootViewController: UIViewController,
                                            title: String,
                                            image: UIImage) -> UIViewController {
    let navigationVC = UINavigationController(rootViewController: rootViewController)
    navigationVC.tabBarItem.title = title
    navigationVC.tabBarItem.image = image
    return navigationVC
  }
}
