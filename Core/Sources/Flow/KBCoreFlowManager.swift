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
import Departments
import Favorites
import Account

public class KBCoreFlowManager {
    
    // MARK: - PROPERTIES
    
    public var rootNavigation: UINavigationController?
    
    var tabBarNavControllers: [UINavigationController] = []
    let serviceManager: KBServiceManagerProtocol = KBServiceManager()
    var onboardingManager: KBOnboardingFlowManager?
    var homeManager: KBHomeFlowManager?
    var categoriesManager: KBCategoriesFlowManager?
    var favoritesManager: KBFavoritesFlowManager?
    var accountManager: KBAccountFlowManager?
    
    // MARK: - INITIALIZERS
    
    public init() {
        setManagers()
        setRootNavigation()
        start()
    }
    
    // MARK: - PUBLIC METHODS
    
    func assembleTabBar() -> UITabBarController? {
        let tabBar = KBTabBarController()
        addHomeTab(to: tabBar)
        addCategoriesTab(to: tabBar)
        addFavoritesTab(to: tabBar)
        addAccountTab(to: tabBar)
        
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        return tabBar
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setRootNavigation() {
        guard let rootVC = onboardingManager?.makeCoverViewController() else { return }
        rootNavigation = UINavigationController(rootViewController: rootVC)
        rootNavigation?.navigationBar.isHidden = true
    }
    
    private func setManagers() {
        setOnboardingManager()
        setHomeManager()
        setDepartmentsManager()
        setFavoritesManager()
        setAccountManager()
    }
    
    private func start() {
        onboardingManager?.start()
    }
}
