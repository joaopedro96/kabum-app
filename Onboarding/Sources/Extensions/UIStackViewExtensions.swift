//
//  UIStackViewExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { itemView in
            addArrangedSubview(itemView)
        }
    }
    
    func removeSubviews() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
        }
    }
}
