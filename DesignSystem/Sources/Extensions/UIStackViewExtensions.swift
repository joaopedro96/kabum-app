//
//  UIStackViewExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach { itemView in
            addArrangedSubview(itemView)
        }
    }
    
    public func removeSubviews() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
        }
    }
}
