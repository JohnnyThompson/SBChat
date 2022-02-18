//
//  UIImage + Extension.swift
//  SBChat
//
//  Created by Евгений Карпов on 18.02.2022.
//

import UIKit

extension UIImage {
  var scaledToSafeUploadSize: UIImage? {
    let maxImageSideLength: CGFloat = 480
    let largeSide: CGFloat = max(size.width, size.height)
    let ratioScale: CGFloat = largeSide > maxImageSideLength ? largeSide / maxImageSideLength : 1
    let newImageSize = CGSize(width: size.width / ratioScale, height: size.height / ratioScale)
    return image(scaledTo: newImageSize)
  }
  func image(scaledTo size: CGSize) -> UIImage? {
    defer {
      UIGraphicsEndImageContext()
    }
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    draw(in: CGRect(origin: .zero, size: size))
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
