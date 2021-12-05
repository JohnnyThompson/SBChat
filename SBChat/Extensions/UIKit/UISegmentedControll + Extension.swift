//
//  UISegmentedControll + Extension.swift
//  SBChat
//
//  Created by Евгений Карпов on 05.12.2021.
//

import UIKit

extension UISegmentedControl {
    
    convenience init(first: String, second: String) {
        self.init()
        self.insertSegment(withTitle: first, at: 0, animated: false)
        self.insertSegment(withTitle: second, at: 1, animated: false)
        self.selectedSegmentIndex = 0
    }
}
