//
//  KBBaseNavigationViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 05/06/23.
//

import UIKit

protocol KBBaseNavigationViewControllerDelegate: AnyObject {
    func didTapNavigationCartItem()
    func didTapNavigationSearchBar(from tabIndex: Int)
    func appendProductToCartList(for productCode: Int)
    func removeProductFromCartList(for productCode: Int)
}

class KBBaseNavigationViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    weak var navigationDelegate: KBBaseNavigationViewControllerDelegate?
        
    var tabBarIndex: Int = 0
    
    var navBarRightIcon: KBNavigationCustomItemView?
        
    var shoppingCartList: [Int] = [] {
        didSet {
            navBarRightIcon?.setBadge(for: shoppingCartList.count)
        }
    }
        
    // MARK: - NAVIGATION BAR METHODS
    
    func addProductToCart(with productCode: Int) {
        navigationDelegate?.appendProductToCartList(for: productCode)
    }
    
    func removeProductFromCart(with productCode: Int) {
        navigationDelegate?.removeProductFromCartList(for: productCode)
    }
    
    func didTapNavigationCartItem() {
        navigationDelegate?.didTapNavigationCartItem()
    }
    
    func didTapNavigationSearchBar() {
        navigationDelegate?.didTapNavigationSearchBar(from: tabBarIndex)
    }
}
