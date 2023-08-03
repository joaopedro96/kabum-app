//
//  UIViewExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

extension UIView {
    public func addSubviews(_ views: UIView...) {
        views.forEach { itemView in
            addSubview(itemView)
        }
    }
    
    public func constraintToSuperview(top: CGFloat = 0,
                               leading: CGFloat = 0,
                               trailing: CGFloat = 0,
                               bottom: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: leading),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: -trailing),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -bottom)
        ])
    }
    
    public func setBadge(for value: Int) {
        removeBadge()
        if value != 0 {
            addBadge(for: value)
        }
    }
    
    private func addBadge(for value: Int) {
        let badge = KBBadgeLabel(value: value)
        addSubview(badge)
        badge.topAnchor.constraint(equalTo: topAnchor).isActive = true
        badge.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func removeBadge() {
        subviews.forEach { view in
            let badge = view as? KBBadgeLabel
            badge?.removeFromSuperview()
        }
    }
}
