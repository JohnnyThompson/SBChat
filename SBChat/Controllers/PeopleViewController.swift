//
//  PeopleViewController.swift
//  SBChat
//
//  Created by Евгений Карпов on 05.12.2021.
//

import UIKit

class PeopleViewController: UIViewController {
  // MARK: - Properties
  let users = Bundle.main.decode([MUser].self, from: "users.json")
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, MUser>!
  enum Section: Int, CaseIterable {
    case users
    func description(usersCount: Int) -> String {
      switch self {
      case .users:
        return "\(usersCount) people nearby"
      }
    }
  }
 // MARK: - Initialization
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
    setupCollectionView()
    createDataSource()
    reloadData(with: nil)
  }
  // MARK: - Module functions
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: view.bounds,
                                      collectionViewLayout: createCompositionLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .mainWhite()
    view.addSubview(collectionView)
    collectionView.register(SectionHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: SectionHeader.reuseId)
    collectionView.register(UserCell.self,
                            forCellWithReuseIdentifier: UserCell.reuseID)
  }
  private func setupSearchBar() {
    navigationController?.navigationBar.tintColor = .mainWhite()
    navigationController?.navigationBar.shadowImage = UIImage()
    let searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }
  private func reloadData(with searchText: String?) {
    let filtered = users.filter { user in
      user.contains(filter: searchText)
    }
    var snapshot = NSDiffableDataSourceSnapshot<Section, MUser>()
    snapshot.appendSections([.users])
    snapshot.appendItems(filtered, toSection: .users)
    dataSource?.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - Setup layout

extension PeopleViewController {
  private func createCompositionLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) in
      guard let section = Section(rawValue: sectionIndex) else {
        fatalError("Unknown section kind")
      }
      switch section {
      case .users:
        return self.createUsersSection()
      }
    }
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 20
    layout.configuration = config
    return layout
  }

  private func createUsersSection() -> NSCollectionLayoutSection {
    let spacing = CGFloat(15)
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                           heightDimension: .fractionalWidth(0.6))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                   subitem: item,
                                                   count: 2)
    group.interItemSpacing = .fixed(spacing)
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    section.contentInsets = NSDirectionalEdgeInsets(top: 16,
                                                    leading: 16,
                                                    bottom: 0,
                                                    trailing: 16)
    let sectionHeader = createSectionHeader()
    section.boundarySupplementaryItems = [sectionHeader]
    return section
  }

  private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let sectionHeaderSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(1)
    )
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: sectionHeaderSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    return sectionHeader
  }
}

// MARK: - DataSource
extension PeopleViewController {
  private func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, MUser>(
      collectionView: collectionView,
      cellProvider: { collectionView, indexPath, user in
        guard let section = Section(rawValue: indexPath.section) else {
          fatalError("Unknown section kind")
        }
        switch section {
        case .users:
          return self.configure(collectionView: collectionView,
                                cellType: UserCell.self,
                                with: user,
                                indexPath: indexPath)
        }
      })
    dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
      guard
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: SectionHeader.reuseId,
          for: indexPath
        ) as? SectionHeader
      else {
        fatalError("Can not create new section Header")
      }
      guard let section = Section(rawValue: indexPath.section) else {
        fatalError("Unknown section kind")
      }
      let items = self.dataSource.snapshot().itemIdentifiers(inSection: .users)
      sectionHeader.configurate(text: section.description(usersCount: items.count),
                                font: .systemFont(ofSize: 36, weight: .light),
                                textColor: .label)
      return sectionHeader
    }
  }
}
// MARK: - UISearchBarDelegate
extension PeopleViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    reloadData(with: searchText)
    print(searchText)
  }
}
// MARK: - SwiftUI
import SwiftUI

struct PeopleControllerProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  struct ContainerView: UIViewControllerRepresentable {
    let tabBarVC = MainTabBarController()
    func makeUIViewController(context: Context) -> some UIViewController {
      return tabBarVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
  }
}
