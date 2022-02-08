//
//  AddPhotoView.swift
//  SBChat
//
//  Created by Евгений Карпов on 05.12.2021.
//

import UIKit

class AddPhotoView: UIView {
// MARK: - Properties
  var circleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = #imageLiteral(resourceName: "avatar")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.borderColor = UIColor.black.cgColor
    imageView.layer.borderWidth = 1
    return imageView
  }()
  let plussButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    let myImage = UIImage(systemName: "plus.circle.fill")
    button.setImage(myImage, for: .normal)
    button.tintColor = .buttonDark()
    return button
  }()
// MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(circleImageView)
    addSubview(plussButton)
    setupConstrains()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Private functions
  private func setupConstrains() {
    NSLayoutConstraint.activate([
      circleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
      circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      circleImageView.heightAnchor.constraint(equalToConstant: 100),
      circleImageView.widthAnchor.constraint(equalToConstant: 100)
    ])
    NSLayoutConstraint.activate([
      plussButton.heightAnchor.constraint(equalToConstant: 30),
      plussButton.widthAnchor.constraint(equalToConstant: 30),
      plussButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      plussButton.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 16)
    ])
    self.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor).isActive = true
    self.trailingAnchor.constraint(equalTo: plussButton.trailingAnchor).isActive = true
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    circleImageView.layer.masksToBounds = true
    circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
  }}
