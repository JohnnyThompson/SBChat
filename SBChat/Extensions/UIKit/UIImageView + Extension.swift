//
//  UIImageView + Extension.swift
//  SBChat
//
//  Created by Евгений Карпов on 03.12.2021.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
