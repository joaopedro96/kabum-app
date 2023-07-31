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
import Departments
import Favorites
import Account

public class KBFlowEngine {
    
    private var tabBarNavControllers: [UINavigationController]
    private let serviceManager: KBServiceManagerProtocol
    private var homeManager: KBHomeFlowManager
    private var categoriesManager: KBCategoriesFlowManager
    private var favoritesManager: KBFavoritesFlowManager
    private var accountManager: KBAccountFlowManager
    
    public init(tabBarNavControllers: [UINavigationController], serviceManager: KBServiceManagerProtocol) {
        self.tabBarNavControllers = tabBarNavControllers
        self.serviceManager = serviceManager
        homeManager = KBHomeFlowManager(serviceManager: serviceManager)
        favoritesManager = KBFavoritesFlowManager(serviceManager: serviceManager)
        categoriesManager = KBCategoriesFlowManager(serviceManager: serviceManager)
        accountManager = KBAccountFlowManager(serviceManager: serviceManager)
        homeManager.homeIntegration = self
        favoritesManager.favoritesIntegration = self
        accountManager.accountIntegration = self
        categoriesManager.categoriesIntegration = self
    }
    
    public func assembleTabBar() -> UITabBarController? {
        let tabBar = KBTabBarController()
        addHomeTab(to: tabBar)
        addCategoriesTab(to: tabBar)
        addFavoritesTab(to: tabBar)
        addAccountTab(to: tabBar)
        
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
    
    private func addCategoriesTab(to tabBar: KBTabBarController) {
        let categoriesVC = categoriesManager.makeCategoriesViewController()
        tabBar.addTab(tabRootController: categoriesVC,
                      title: "Categorias",
                      image: UIImage.categorieIcon)
        categoriesManager.setNavigation(with: tabBar.navigationControllers.last)
    }
    
    private func addFavoritesTab(to tabBar: KBTabBarController) {
        let favoritesVC = favoritesManager.makeFavoritesViewController()
        tabBar.addTab(tabRootController: favoritesVC,
                      title: "Favoritos",
                      image: UIImage.heartIcon)
        favoritesManager.setNavigation(with: tabBar.navigationControllers.last)
    }
    
    private func addAccountTab(to tabBar: KBTabBarController) {
        let accountVC = accountManager.makeAccountViewController()
        tabBar.addTab(tabRootController: accountVC,
                      title: "Minha Conta",
                      image: UIImage.accountIcon)
        accountManager.setNavigation(with: tabBar.navigationControllers.last)
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

extension KBFlowEngine: KBAccountModuleIntegrationProtocol { }

extension KBFlowEngine: KBFavoritesModuleIntegrationProtocol { }

extension KBFlowEngine: KBCategoriesModuleIntegrationProtocol { }
