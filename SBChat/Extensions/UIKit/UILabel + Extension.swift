//
//  Label + Extension.swift
//  SBChat
//
//  Created by Евгений Карпов on 03.12.2021.
//

import UIKit

extension UILabel {
    
    convenience init(text: String,
                     font: UIFont? = .avenir20()){
        self.init()
        self.text = text
        self.font = font
        
    }
    
}
