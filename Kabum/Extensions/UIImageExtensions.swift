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
    
    
    // MARK: - INITIALIZER
    
    fileprivate class func initialize(with name: String) -> UIImage {
        return UIImage(named: name, in: Bundle.main, compatibleWith: nil) ?? UIImage()
    }
}
