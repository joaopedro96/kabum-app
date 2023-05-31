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
        setupTabBar()
    }
    
    // MARK: - PUBLIC METHODS
    
    func addTab(viewController: UIViewController, title: String, image: UIImage) {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem = UITabBarItem(title: title,
                                                       image: image,
                                                       tag: navigationControllers.count)
        
        navigationControllers.append(navigationController)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .theme
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.standardAppearance = appearance;
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance

        setViewControllers(navigationControllers, animated: true)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupTabBar() {
        tabBar.backgroundColor = .theme
        tabBar.isTranslucent = false
    }
}
