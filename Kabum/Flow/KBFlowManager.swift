//
//  KBFlowManager.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

final class KBFlowManager: UINavigationController {
    
    // MARK: - PROPERTIES
    
    private var tabBarNavControllers: [UINavigationController] = []
    
    // MARK: - INITIALIZERS
    
    init(rootViewController: KBCoverViewController = KBCoverViewController()) {
        super.init(rootViewController: rootViewController)
        navigationBar.isHidden = true
        rootViewController.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func assembleTabBar(with data: KBHomeModel) -> UITabBarController {
        let tabBar = KBTabBarController()
        
        let homeVC = makeHomeViewController(with: data)
        let categoriesVC = makeCategoriesViewController()
        let favoritesVC = makeFavoritesViewController()
        let accountVC = makeAccountViewController()
        
        tabBar.addTab(viewController: homeVC,
                      title: "Início",
                      image: .homeIcon)
        
        tabBar.addTab(viewController: categoriesVC,
                      title: "Categorias",
                      image: .categorieIcon)
        
        tabBar.addTab(viewController: favoritesVC,
                      title: "Favoritos",
                      image: .heartIcon)
        
        tabBar.addTab(viewController: accountVC,
                      title: "Minha Conta",
                      image: .accountIcon)
        
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        
        return tabBar
    }
        
    // MARK: - MAKE CONTROLLERS
    
    private func makeHomeViewController(with data: KBHomeModel) -> KBHomeViewController {
        let viewController = KBHomeViewController(productList: data.products)
        return viewController
    }
    
    private func makeCategoriesViewController() -> KBCategoriesViewController {
        let viewController = KBCategoriesViewController()
        return viewController
    }
    
    private func makeFavoritesViewController() -> KBFavoritesViewController {
        let viewController = KBFavoritesViewController()
        return viewController
    }
    
    private func makeAccountViewController() -> KBAccountViewController {
        let viewController = KBAccountViewController()
        return viewController
    }
}

// MARK: - EXTENSIONS

extension KBFlowManager: KBCoverViewControllerDelegate {
    func goToHomePage(with homeData: KBHomeModel) {
        let tabBar = assembleTabBar(with: homeData)
        pushViewController(tabBar, animated: false)
    }
}

extension KBFlowManager: KBHomeViewControllerDelegate{
    func goToProductDetailsPage(with url: String) {
        ///Detail Page should be called here using url parameter as its depedency injection
        print(url)
    }
}
