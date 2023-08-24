//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import UIKit
import Departments
import DesignSystem

extension KBCoreFlowManager {
    func setDepartmentsManager() {
        categoriesManager = KBCategoriesFlowManager(serviceManager: serviceManager)
        homeManager?.homeIntegration = self
        categoriesManager?.categoriesIntegration = self
    }
    
    func addCategoriesTab(to tabBar: KBTabBarController) {
        guard let categoriesVC = categoriesManager?.makeCategoriesViewController() else { return }
        tabBar.addTab(tabRootController: categoriesVC,
                      title: "Categorias",
                      image: UIImage.categorieIcon)
        categoriesManager?.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBCoreFlowManager: KBCategoriesModuleIntegrationProtocol { }
