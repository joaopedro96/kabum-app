//
//  KBBaseNavigationViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 05/06/23.
//

import UIKit

public protocol KBBaseNavigationViewControllerDelegate: AnyObject {
    func didTapNavigationCartItem()
    func didTapNavigationSearchBar(from tabIndex: Int)
    func appendProductToCartList(for productCode: Int)
    func removeProductFromCartList(for productCode: Int)
}

open class KBBaseNavigationViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    public weak var navigationDelegate: KBBaseNavigationViewControllerDelegate?
        
    public var tabBarIndex: Int = 0
    
    public var navBarRightIcon: KBNavigationCustomItemView?
        
    public var shoppingCartList: [Int] = [] {
        didSet {
            navBarRightIcon?.setBadge(for: shoppingCartList.count)
        }
    }
        
    // MARK: - NAVIGATION BAR METHODS
    
    public func addProductToCart(with productCode: Int) {
        navigationDelegate?.appendProductToCartList(for: productCode)
    }
    
    public func removeProductFromCart(with productCode: Int) {
        navigationDelegate?.removeProductFromCartList(for: productCode)
    }
    
    public func didTapNavigationCartItem() {
        navigationDelegate?.didTapNavigationCartItem()
    }
    
    public func didTapNavigationSearchBar() {
        navigationDelegate?.didTapNavigationSearchBar(from: tabBarIndex)
    }
}
