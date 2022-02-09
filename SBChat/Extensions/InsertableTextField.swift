//
//  InsertableTextField.swift
//  SBChat
//
//  Created by Евгений Карпов on 09.02.2022.
//

import UIKit

class InsertableTextField: UITextField {
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    placeholder = "Write something here ..."
    font = UIFont.systemFont(ofSize: 14)
    borderStyle = .none
    layer.cornerRadius = 18
    layer.masksToBounds = true
    let image = UIImage(systemName: "smiley")
    let imageView = UIImageView(image: image)
    imageView.setupColor(color: .lightGray)
    leftView = imageView
    leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
    leftViewMode = .always
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "Sent"), for: .normal)
    button.applyGradients(cornerRadius: 10)
    rightView = button
    rightView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
    rightViewMode = .always
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Functions
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.leftViewRect(forBounds: bounds)
    rect.origin.x += 12
    return rect
  }
  override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.rightViewRect(forBounds: bounds)
    rect.origin.x -= 12
    return rect
  }
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 36, dy: 0)
  }
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 36, dy: 0)
  }
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 36, dy: 0)
  }
}
// MARK: - SwiftUI
import SwiftUI

struct InsertableTextFieldProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  struct ContainerView: UIViewControllerRepresentable {
    let tabBarVC = ProfileViewController()
    func makeUIViewController(context: Context) -> some UIViewController {
      return tabBarVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  }
}
