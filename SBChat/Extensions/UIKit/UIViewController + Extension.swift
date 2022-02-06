//
//  UIViewController + Extension.swift
//  SBChat
//
//  Created by Евгений Карпов on 06.02.2022.
//

import UIKit

extension UIViewController {
  func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView,
                                                      cellType: T.Type,
                                                      with value: U,
                                                      indexPath: IndexPath) -> T {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID,
                                                        for: indexPath) as? T else {
      fatalError("Unable to dequue \(cellType)")
    }
    cell.configure(with: value)
    return cell
  }
}
