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
    private let serviceManager: KBServiceManagerProtocol = KBServiceManager()
    
    // MARK: - INITIALIZERS
    
    init() {
        let viewModel = KBCoverViewModel(service: serviceManager)
        let rootVC = KBCoverViewController(viewModel: viewModel)
        super.init(rootViewController: rootVC)
        navigationBar.isHidden = true
        rootVC.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func assembleTabBar(with homeResponse: KBHomeResponse) -> UITabBarController {
        let tabBar = KBTabBarController()
        
        let homeVC = makeHomeViewController(with: homeResponse)
        let categoriesVC = makeCategoriesViewController()
        let favoritesVC = makeFavoritesViewController()
        let accountVC = makeAccountViewController()
        
        tabBar.addTab(tabRootController: homeVC,
                      title: "Início",
                      image: .homeIcon)
        
        tabBar.addTab(tabRootController: categoriesVC,
                      title: "Categorias",
                      image: .categorieIcon)
        
        tabBar.addTab(tabRootController: favoritesVC,
                      title: "Favoritos",
                      image: .heartIcon)
        
        tabBar.addTab(tabRootController: accountVC,
                      title: "Minha Conta",
                      image: .accountIcon)
        
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        
        return tabBar
    }
        
    // MARK: - MAKE CONTROLLERS
    
    private func makeHomeViewController(with data: KBHomeResponse) -> KBHomeViewController {
        let viewModel = KBHomeViewModel(service: serviceManager, homeResponse: data)
        let viewController = KBHomeViewController(viewModel: viewModel)
        viewController.navigationDelegate = self
        viewController.delegate = self
        return viewController
    }
    
    private func makeCategoriesViewController() -> KBCategoriesViewController {
        let viewController = KBCategoriesViewController()
        viewController.navigationDelegate = self
        return viewController
    }
    
    private func makeFavoritesViewController() -> KBFavoritesViewController {
        let viewController = KBFavoritesViewController()
        viewController.navigationDelegate = self
        return viewController
    }
    
    private func makeAccountViewController() -> KBAccountViewController {
        let viewController = KBAccountViewController()
        viewController.navigationDelegate = self
        return viewController
    }
    
    private func makeProductsDetailViewController(with url: String) -> KBProductDetailsViewController {
        let viewController = KBProductDetailsViewController(productUrl: url, service: serviceManager)
        return viewController
    }
    
    // MARK: - PRIVATE METHODS
    
    private func goToSearchPage(from tabIndex: Int) {
        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .orange
        searchVC.title = "Pesquisar"
        tabBarNavControllers[tabIndex].pushViewController(searchVC, animated: true)
    }
    
    private func presentShoppingCartPage() {
        let shoppingCartVC = UIViewController()
        shoppingCartVC.view.backgroundColor = .gray200
        present(shoppingCartVC, animated: true)
    }
}

// MARK: - EXTENSIONS

extension KBFlowManager: KBBaseNavigationViewControllerDelegate {
    func didTapNavigationCartItem() {
        presentShoppingCartPage()
    }
    
    func didTapNavigationSearchBar(from tabIndex: Int) {
        goToSearchPage(from: tabIndex)
    }
    
    func appendProductToCartList(for productCode: Int) {
        tabBarNavControllers.forEach { navigationController in
            let navController = navigationController as? KBSearchableNavigationController
            navController?.rootViewController.shoppingCartList.append(productCode)
        }
    }
    
    func removeProductFromCartList(for productCode: Int) {
        tabBarNavControllers.forEach { navigationController in
            let navController = navigationController as? KBSearchableNavigationController
            navController?.rootViewController.shoppingCartList.removeAll(where: { $0 == productCode } )
        }
    }
}

extension KBFlowManager: KBCoverViewControllerDelegate {
    func goToHomePage(with response: KBHomeResponse) {
        
        ///Delete CoverView from navigation stack to prevent going back to cover page
        viewControllers.removeAll()
        
        let tabBar = assembleTabBar(with: response)
        pushViewController(tabBar, animated: false)
    }
}

extension KBFlowManager: KBHomeViewControllerDelegate {
    
    ///Demonstration about how 'tabBarNavControllers' should be called
    func goToProductDetailsPage(from tabIndex: Int, with url: String) {
        let detailVC = makeProductsDetailViewController(with: url)
        tabBarNavControllers[tabIndex].pushViewController(detailVC, animated: true)
    }
}
