//
//  KBFlowEngine.swift
//  Core
//
//  Created by João Pedro Mata on 26/07/23.
//

import UIKit
import Network
import DesignSystem
import Home

public class KBFlowEngine {
    
    public var tabBarNavControllers: [UINavigationController]
    public let serviceManager: KBServiceManagerProtocol
    private var homeManager: KBHomeFlowManager
    
    public init(tabBarNavControllers: [UINavigationController],
                serviceManager: KBServiceManagerProtocol) {
        self.tabBarNavControllers = tabBarNavControllers
        self.serviceManager = serviceManager
        self.homeManager = KBHomeFlowManager(serviceManager: serviceManager)
    }
    
    public func assembleTabBar() -> UITabBarController? {
        let tabBar = KBTabBarController()
        addHomeTab(to: tabBar)
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        return tabBar
    }
    
    private func addHomeTab(to tabBar: KBTabBarController) {
        let homeVC = homeManager.makeHomeViewController()
        tabBar.addTab(tabRootController: homeVC,
                      title: "Início",
                      image: UIImage.homeIcon)
        homeManager.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBFlowEngine: KBHomeModuleIntegrationProtocol {
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
