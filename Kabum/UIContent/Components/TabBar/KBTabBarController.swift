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
    
    func addTab(viewController: UIViewController, title: String, image: UIImage) {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let normalStateImage = image.withRenderingMode(.alwaysOriginal).withTintColor(.blue100)
        let activeStateImage = image.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        navigationController.tabBarItem = UITabBarItem(title: title,
                                                       image: normalStateImage,
                                                       selectedImage: activeStateImage)
        
        navigationController.tabBarItem.tag = navigationControllers.count
        navigationControllers.append(navigationController)
        setupNavBarAppearance()
        
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
    
    private func setupNavBarAppearance() {
        let navBar = navigationControllers.last?.navigationBar
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .theme
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBar?.standardAppearance = appearance
        navBar?.scrollEdgeAppearance = navBar?.standardAppearance
    }
}
