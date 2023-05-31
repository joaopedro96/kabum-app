//
//  UIViewExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { itemView in
            addSubview(itemView)
        }
    }
}
