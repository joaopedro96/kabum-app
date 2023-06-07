//
//  KBTabBarController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

final class KBTabBarController: UITabBarController {
    
    // MARK: - PROPERTIES
    
    var navigationControllers: [UINavigationController] = []
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
    }
    
    // MARK: - PUBLIC METHODS
    
    func addTab(tabRootController: KBBaseNavigationViewController, title: String, image: UIImage) {
        let navController = KBSearchableNavigationController(rootViewController: tabRootController)
        
        navController.tabBarItem = UITabBarItem(title: title,
                                                image: image.withTintColor(.blue100),
                                                selectedImage: image.withTintColor(.white))
        
        tabRootController.tabBarIndex = navigationControllers.count
        navigationControllers.append(navController)
        
        setViewControllers(navigationControllers, animated: true)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupTabBarAppearance() {
        let normalStateColor = [NSAttributedString.Key.foregroundColor: UIColor.blue100]
        let selectedStateColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .theme
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalStateColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedStateColor
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
