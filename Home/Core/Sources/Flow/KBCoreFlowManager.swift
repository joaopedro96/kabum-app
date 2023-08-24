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
import Home

public class KBCoreFlowManager: UINavigationController {
    
    public var tabBarNavControllers: [UINavigationController] = []
    public let serviceManager: KBServiceManagerProtocol = KBServiceManager()
    private var onboardingManager: KBOnboardingFlowManager
    private var homeManager: KBHomeFlowManager
    
    public init() {
        onboardingManager = KBOnboardingFlowManager(serviceManager: serviceManager)
        homeManager = KBHomeFlowManager(serviceManager: serviceManager)
        let rootVC = onboardingManager.makeCoverViewController()
        super.init(rootViewController: rootVC)
        onboardingManager.onboardingIntegration = self
        homeManager.homeIntegration = self
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

extension KBCoreFlowManager: KBOnboardingModuleIntegrationProtocol {
    public func setupTabBar() {
        viewControllers.removeAll()
        
        guard let tabBar = assembleTabBar() else { return }
        pushViewController(tabBar, animated: false)
    }
}


extension KBCoreFlowManager: KBHomeModuleIntegrationProtocol {
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
