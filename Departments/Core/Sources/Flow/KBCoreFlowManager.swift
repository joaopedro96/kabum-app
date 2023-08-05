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
import Departments

public class KBCoreFlowManager: UINavigationController {
    
    private var tabBarNavControllers: [UINavigationController] = []
    private let serviceManager: KBServiceManagerProtocol = KBServiceManager()
    private var onboardingManager: KBOnboardingFlowManager
    private var categoriesManager: KBCategoriesFlowManager
    
    public init() {
        onboardingManager = KBOnboardingFlowManager(serviceManager: serviceManager)
        categoriesManager = KBCategoriesFlowManager(serviceManager: serviceManager)
        let rootVC = onboardingManager.makeCoverViewController()
        super.init(rootViewController: rootVC)
        onboardingManager.onboardingIntegration = self
        categoriesManager.categoriesIntegration = self
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

extension KBCoreFlowManager: KBCategoriesModuleIntegrationProtocol {
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

extension KBCoreFlowManager: KBOnboardingModuleIntegrationProtocol {
    public func setupTabBar() {
        viewControllers.removeAll()
        
        guard let tabBar = assembleTabBar() else { return }
        pushViewController(tabBar, animated: false)
    }
}
