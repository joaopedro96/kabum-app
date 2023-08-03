//
//  KBFlowEngine.swift
//  Core
//
//  Created by João Pedro Mata on 26/07/23.
//

import UIKit
import Network
import DesignSystem
import Favorites

public class KBFlowEngine {
    
    public var tabBarNavControllers: [UINavigationController]
    public let serviceManager: KBServiceManagerProtocol
    private var favoritesManager: KBFavoritesFlowManager
    
    public init(tabBarNavControllers: [UINavigationController], serviceManager: KBServiceManagerProtocol) {
        self.tabBarNavControllers = tabBarNavControllers
        self.serviceManager = serviceManager
        favoritesManager = KBFavoritesFlowManager(serviceManager: serviceManager)
        favoritesManager.favoritesIntegration = self
    }
    
    public func assembleTabBar() -> UITabBarController? {
        let tabBar = KBTabBarController()
        addFavoritesTab(to: tabBar)
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        return tabBar
    }
    
    private func addFavoritesTab(to tabBar: KBTabBarController) {
        let favoritesVC = favoritesManager.makeFavoritesViewController()
        tabBar.addTab(tabRootController: favoritesVC,
                      title: "Favoritos",
                      image: UIImage.heartIcon)
        favoritesManager.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBFlowEngine: KBFavoritesModuleIntegrationProtocol {
    public func appendProductToCartList(for productCode: Int) {
        tabBarNavControllers.forEach { navigationController in
            let navController = navigationController as? KBSearchableNavigationController
            navController?.rootViewController.shoppingCartList.append(productCode)
        }
    }
    
    public func removeProductFromCartList(for productCode: Int) {
        tabBarNavControllers.forEach { navigationController in
            let navController = navigationController as? KBSearchableNavigationController
            navController?.rootViewController.shoppingCartList.removeAll(where: { $0 == productCode } )
        }
    }
}
