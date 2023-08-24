//
//  KBCoreFlowManager.swift
//  Core
//
//  Created by João Pedro Mata on 26/07/23.
//

import UIKit
import Network
import DesignSystem
import Onboarding
import Favorites

public class KBCoreFlowManager: UINavigationController {
    
    public var tabBarNavControllers: [UINavigationController] = []
    public let serviceManager: KBServiceManagerProtocol = KBServiceManager()
    private var onboardingManager: KBOnboardingFlowManager
    private var favoritesManager: KBFavoritesFlowManager
    
    public init() {
        onboardingManager = KBOnboardingFlowManager(serviceManager: serviceManager)
        favoritesManager = KBFavoritesFlowManager(serviceManager: serviceManager)
        let rootVC = onboardingManager.makeCoverViewController()
        super.init(rootViewController: rootVC)
        onboardingManager.onboardingIntegration = self
        favoritesManager.favoritesIntegration = self
        navigationBar.isHidden = true
        start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func start() {
        onboardingManager.start()
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

extension KBCoreFlowManager: KBOnboardingModuleIntegrationProtocol {
    public func setupTabBar() {
        viewControllers.removeAll()
        
        guard let tabBar = assembleTabBar() else { return }
        pushViewController(tabBar, animated: false)
    }
}


extension KBCoreFlowManager: KBFavoritesModuleIntegrationProtocol {
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
