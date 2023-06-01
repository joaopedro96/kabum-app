//
//  UICollorExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

extension UIColor {
    
    // MARK: - THEME
    
    class var theme: UIColor {
        guard let storedColor = UIColor(named: "theme") else { return .red }
        return storedColor
    }
    
    // MARK: - BLUE
    
    class var blue100: UIColor {
        guard let storedColor = UIColor(named: "blue100") else { return .red }
        return storedColor
    }
    
    class var blue200: UIColor {
        guard let storedColor = UIColor(named: "blue200") else { return .red }
        return storedColor
    }
    
    // MARK: - ORANGE
    
    class var orange500: UIColor {
        guard let storedColor = UIColor(named: "orange500") else { return .red }
        return storedColor
    }
    
    // MARK: - GRAYSCALE
    
    class var gray100: UIColor {
        guard let storedColor = UIColor(named: "gray100") else { return .red }
        return storedColor
    }
    
    class var gray200: UIColor {
        guard let storedColor = UIColor(named: "gray200") else { return .red }
        return storedColor
    }
    
    class var gray300: UIColor {
        guard let storedColor = UIColor(named: "gray300") else { return .red }
        return storedColor
    }
    
    class var gray400: UIColor {
        guard let storedColor = UIColor(named: "gray400") else { return .red }
        return storedColor
    }
    
    class var gray500: UIColor {
        guard let storedColor = UIColor(named: "gray500") else { return .red }
        return storedColor
    }
}
