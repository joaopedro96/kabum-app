//
//  UICollorExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

extension UIColor {
    
    // MARK: - THEME
    
    public class var theme: UIColor {
        guard let storedColor = UIColor(named: "theme") else { return .red }
        return storedColor
    }
    
    // MARK: - BLUE SCALE
    
    public class var blue100: UIColor {
        guard let storedColor = UIColor(named: "blue100") else { return .red }
        return storedColor
    }
    
    public class var blue200: UIColor {
        guard let storedColor = UIColor(named: "blue200") else { return .red }
        return storedColor
    }
    
    // MARK: - ORANGE SCALE
    
    public class var orange500: UIColor {
        guard let storedColor = UIColor(named: "orange500") else { return .red }
        return storedColor
    }
    
    // MARK: - GRAY SCALE
    
    public class var gray100: UIColor {
        guard let storedColor = UIColor(named: "gray100") else { return .red }
        return storedColor
    }
    
    public class var gray200: UIColor {
        guard let storedColor = UIColor(named: "gray200") else { return .red }
        return storedColor
    }
    
    public class var gray300: UIColor {
        guard let storedColor = UIColor(named: "gray300") else { return .red }
        return storedColor
    }
    
    public class var gray400: UIColor {
        guard let storedColor = UIColor(named: "gray400") else { return .red }
        return storedColor
    }
    
    public class var gray500: UIColor {
        guard let storedColor = UIColor(named: "gray500") else { return .red }
        return storedColor
    }
}
