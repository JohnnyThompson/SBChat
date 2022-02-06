//
//  MainTabBarController.swift
//  SBChat
//
//  Created by Евгений Карпов on 05.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
  // MARK: - Initialization
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.tintColor = #colorLiteral(red: 0.5568627451, green: 0.3529411765, blue: 0.968627451, alpha: 1)
    let listViewController = ListViewController()
    let peopleViewController = PeopleViewController()
    let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)!
    let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfiguration)!
    viewControllers = [
      generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
      generateNavigationController(rootViewController: listViewController, title: "Conversation", image: convImage)
    ]
  }
  
  // MARK: - Module functions
  private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
    let navigationVC = UINavigationController(rootViewController: rootViewController)
    navigationVC.tabBarItem.title = title
    navigationVC.tabBarItem.image = image
    return navigationVC
  }
}
