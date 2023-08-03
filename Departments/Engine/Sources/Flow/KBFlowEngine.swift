//
//  KBFlowEngine.swift
//  Core
//
//  Created by João Pedro Mata on 26/07/23.
//

import UIKit
import Network
import DesignSystem
import Departments

public class KBFlowEngine {
    
    public var tabBarNavControllers: [UINavigationController]
    public let serviceManager: KBServiceManagerProtocol
    private var categoriesManager: KBCategoriesFlowManager
    
    public init(tabBarNavControllers: [UINavigationController], serviceManager: KBServiceManagerProtocol) {
        self.tabBarNavControllers = tabBarNavControllers
        self.serviceManager = serviceManager
        categoriesManager = KBCategoriesFlowManager(serviceManager: serviceManager)
        categoriesManager.categoriesIntegration = self
    }
    
    public func assembleTabBar() -> UITabBarController? {
        let tabBar = KBTabBarController()
        addCategoriesTab(to: tabBar)
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        return tabBar
    }
    
    private func addCategoriesTab(to tabBar: KBTabBarController) {
        let categoriesVC = categoriesManager.makeCategoriesViewController()
        tabBar.addTab(tabRootController: categoriesVC,
                      title: "Categorias",
                      image: UIImage.categorieIcon)
        categoriesManager.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBFlowEngine: KBCategoriesModuleIntegrationProtocol {
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
