//
//  UIImageExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

extension UIImage {
    
    // MARK: - ICONS
    
    public class var logoImage: UIImage {
        return initialize(with: "logo")
    }
    
    // MARK: - INITIALIZER
    
    fileprivate class func initialize(with name: String) -> UIImage {
        return UIImage(named: name, in: Bundle.main, compatibleWith: nil) ?? UIImage()
    }
}
