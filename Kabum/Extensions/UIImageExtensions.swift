//
//  UIImageExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

extension UIImage {
    
    // MARK: - ICONS
    
    class var boxIcon: UIImage {
        return initialize(with: "box_icon")
    }
    
    class var logoImage: UIImage {
        return initialize(with: "logo_icon")
    }
    
    class var ninjaIcon: UIImage {
        return initialize(with: "ninja_icon")
    }
    
    class var primeIcon: UIImage {
        return initialize(with: "prime_icon")
    }
    
    class var shippingIcon: UIImage {
        return initialize(with: "shipping_icon")
    }
    
    // MARK: - SYSTEM ICONS
    
    class var heartIcon: UIImage {
        return initializeSystemIcon(with: "heart.fill")
    }
    
    class var homeIcon: UIImage {
        return initializeSystemIcon(with: "house.fill")
    }
    
    class var categorieIcon: UIImage {
        return initializeSystemIcon(with: "list.dash")
    }
    
    class var accountIcon: UIImage {
        return initializeSystemIcon(with: "person.circle")
    }
    
    class var cartIcon: UIImage {
        return initializeSystemIcon(with: "cart.fill")
    }
    
    class var cancelIcon: UIImage {
        return initializeSystemIcon(with: "multiply.circle")
    }
    
    class var searchIcon: UIImage {
        return initializeSystemIcon(with: "magnifyingglass")
    }
    
    // MARK: - INITIALIZER
    
    fileprivate class func initialize(with name: String) -> UIImage {
        return UIImage(named: name, in: Bundle.main, compatibleWith: nil) ?? UIImage()
    }
    
    fileprivate class func initializeSystemIcon(with systemName: String) -> UIImage {
        return UIImage(systemName: systemName)?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    }
}
