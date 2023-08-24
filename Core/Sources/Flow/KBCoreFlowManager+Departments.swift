//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import Departments
import UIKit
import DesignSystem

extension KBCoreFlowManager {
    func setDepartmentsManager() {
        let flowManager = KBDepartmentsFlowManager(serviceManager: serviceManager)
        flowManager.integration = self
        departmentsManager = flowManager
    }
    
    func addCategoriesTab(to tabBar: KBTabBarController) {
        guard let departmentsManager = departmentsManager as? KBDepartmentsFlowManager else { return }

        let categoriesVC = departmentsManager.makeDepartmentsViewController()
        tabBar.addTab(tabRootController: categoriesVC,
                      title: "Categorias",
                      image: UIImage.categorieIcon)
        departmentsManager.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBCoreFlowManager: KBCategoriesModuleIntegrationProtocol { }
