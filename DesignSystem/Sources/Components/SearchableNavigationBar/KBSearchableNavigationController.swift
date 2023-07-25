//
//  KBSearchableNavigationController.swift
//  Kabum
//
//  Created by João Pedro Mata on 05/06/23.
//

import UIKit

final public class KBSearchableNavigationController: UINavigationController {

    // MARK: - PROPERTIES

    public let rootViewController: KBBaseNavigationViewController
    
    // MARK: - INITIALIZERS

    public init(rootViewController: KBBaseNavigationViewController) {
        self.rootViewController = rootViewController
        super.init(rootViewController: rootViewController)
        setupSearchNavBar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - PRIVATE METHODS

    private func setupSearchNavBar() {
        configureNavBarItems()
        configureNavBarAppearance()
        customizeNavBar()
    }

    private func configureNavBarItems() {
        let searchBar = KBNavigationSearchBarView()
        searchBar.delegate = self

        let rightIcon = KBNavigationCustomItemView()
        rightIcon.delegate = self
        rootViewController.navBarRightIcon = rightIcon

        navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: rightIcon)
    }

    private func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .theme
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }

    private func customizeNavBar() {
        navigationBar.tintColor = .white
        navigationBar.topItem?.backButtonTitle = "Voltar"
    }
}

// MARK: - EXTENSIONS

extension KBSearchableNavigationController: KBNavigationSearchBarDelegate {
    func didTapNavigationSearchBar() {
        rootViewController.didTapNavigationSearchBar()
    }
}

extension KBSearchableNavigationController: KBNavigationBarCustomItemViewDelegate {
    public func didTapNavigationItem() {
        rootViewController.didTapNavigationCartItem()
    }
}