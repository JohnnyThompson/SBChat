//
//  GradientView.swift
//  SBChat
//
//  Created by Евгений Карпов on 26.12.2021.
//

import UIKit

class GradientView: UIView {
  private let gradientLayer = CAGradientLayer()
  enum Point {
    case topLeading, leading, bottomLeading, top, center, botoom, topTrailing
    case trailing
    case bottomTrailing
    var point: CGPoint {
      switch self {
      case .topLeading:
        return CGPoint(x: 0, y: 0)
      case .leading:
        return CGPoint(x: 0, y: 0.5)
      case .bottomLeading:
        return CGPoint(x: 0, y: 1.0)
      case .top:
        return CGPoint(x: 0.5, y: 0)
      case .center:
        return CGPoint(x: 0.5, y: 0.5)
      case .botoom:
        return CGPoint(x: 0.5, y: 1.0)
      case .topTrailing:
        return CGPoint(x: 1.0, y: 0.0)
      case .trailing:
        return CGPoint(x: 1.0, y: 0.5)
      case .bottomTrailing:
        return CGPoint(x: 1.0, y: 1.0)
      }
    }
  }
  @IBInspectable private var starColor: UIColor? {
    didSet {
      setupGradientColors(startColor: starColor, endColor: endColor)
    }
  }
  @IBInspectable private var endColor: UIColor? {
    didSet {
      setupGradientColors(startColor: starColor, endColor: endColor)
    }
  }
  init(from: Point, toThe: Point, startColor: UIColor?, endColor: UIColor?) {
    self.init()
    setupGradient(from: from, toThe: toThe, startColor: startColor, endColor: endColor)
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupGradient(from: .leading, toThe: .trailing, startColor: starColor, endColor: endColor)
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }
  private func setupGradient(from: Point, toThe: Point, startColor: UIColor?, endColor: UIColor?) {
    self.layer.addSublayer(gradientLayer)
    setupGradientColors(startColor: startColor, endColor: endColor)
    gradientLayer.startPoint = from.point
    gradientLayer.endPoint = toThe.point
  }
  private func setupGradientColors(startColor: UIColor?, endColor: UIColor?) {
    if let starColor = startColor, let endColor = endColor {
      gradientLayer.colors = [starColor.cgColor, endColor.cgColor]
    }
  }
}
