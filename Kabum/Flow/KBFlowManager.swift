//
//  KBFlowManager.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

final class KBFlowManager: UINavigationController {
    
    // MARK: - PROPERTIES
    
    var tabBarNavControllers: [UINavigationController] = []
    
    init(rootViewController: KBCoverViewController = KBCoverViewController()) {
        super.init(rootViewController: rootViewController)
        navigationBar.isHidden = true
        rootViewController.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func assembleTabBar(with data: KBHomeModel) -> UITabBarController {
        let tabBar = KBTabBarController()
        
        let homeVC = makeHomeViewController(with: data)
        let categoriesVC = makeCategoriesViewController()
        let favoritesVC = makeFavoritesViewController()
        let accountVC = makeAccountViewController()
        
        
        
        tabBar.addTab(viewController: homeVC,
                      title: "Início",
                      image: UIImage(systemName: "house.fill") ?? .checkmark)
        
        tabBar.addTab(viewController: categoriesVC,
                      title: "Categorias",
                      image: UIImage(systemName: "list.dash") ?? .checkmark)
        
        tabBar.addTab(viewController: favoritesVC,
                      title: "Favoritos",
                      image: UIImage(systemName: "heart.fill") ?? .checkmark)
        
        tabBar.addTab(viewController: accountVC,
                      title: "Minha Conta",
                      image: UIImage(systemName: "person.circle") ?? .checkmark)
        
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        
        return tabBar
    }
    
    // MARK: - PUBLIC METHODS
    
    func makeHomeViewController(with data: KBHomeModel) -> KBHomeViewController {
        let viewController = KBHomeViewController(productList: data.products)
        return viewController
    }
    
    func makeCategoriesViewController() -> KBCategoriesViewController {
        let viewController = KBCategoriesViewController()
        return viewController
    }
    
    func makeFavoritesViewController() -> KBFavoritesViewController {
        let viewController = KBFavoritesViewController()
        return viewController
    }
    
    func makeAccountViewController() -> KBAccountViewController {
        let viewController = KBAccountViewController()
        return viewController
    }

//    func makeCharacterDetailViewController(with data: RMCharacterDetailResponse) -> RMCharacterDetailViewController {
//        let detailViewModel = RMCharacterDetailViewModel(characterData: data)
//        let viewController = RMCharacterDetailViewController(viewModel: detailViewModel)
//        detailViewModel.viewController = viewController
//        viewController.delegate = self
//        return viewController
//    }
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
