//
//  File.swift
//  
//
//  Created by João Pedro Mata on 30/07/23.
//

import UIKit
import Network
import DesignSystem

final public class KBCategoriesFlowManager {
    
    private var navigationController: UINavigationController?
    private let serviceManager: KBServiceManagerProtocol
    
    public weak var categoriesIntegration: KBCategoriesModuleIntegrationProtocol?
    
    public init(serviceManager: KBServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    // MARK: - MODULE INTEGRATOR

    public func makeCategoriesViewController() -> KBCategoriesViewController {
        let viewController = KBCategoriesViewController()
        viewController.navigationDelegate = self
        return viewController
    }
    
    public func setNavigation(with navigation: UINavigationController?) {
        navigationController = navigation
    }
    
    private func presentShoppingCartPage() {
        let shoppingCartVC = UIViewController()
        shoppingCartVC.view.backgroundColor = .gray200
        navigationController?.present(shoppingCartVC, animated: true)
    }
    
    private func goToSearchPage() {
        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .orange
        searchVC.title = "Pesquisar"
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}

extension KBCategoriesFlowManager: KBBaseNavigationViewControllerDelegate {
    public func didTapNavigationCartItem() {
        presentShoppingCartPage()
    }
    
    public func didTapNavigationSearchBar(from tabIndex: Int) {
        goToSearchPage()
    }
    
    public func appendProductToCartList(for productCode: Int) {
        categoriesIntegration?.appendProductToCartList(for: productCode)
    }
    
    public func removeProductFromCartList(for productCode: Int) {
        categoriesIntegration?.removeProductFromCartList(for: productCode)
    }
}
