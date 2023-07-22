//
//  KBBadgeLabel.swift
//  Kabum
//
//  Created by João Pedro Mata on 06/06/23.
//

import UIKit

final class KBBadgeLabel: UILabel {
    
    // MARK: - PROPERTIES
    
    private let padding: CGFloat = 4
    private let valueText: String
    
    // MARK: - INITIALIZERS

    init(value: Int) {
        self.valueText = String(value)
        super.init(frame: .zero)
        setupBadgeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OVERRIDE METHODS
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        var content = super.intrinsicContentSize
        content.width += padding
        return content
    }
    
    
    // MARK: - SETUP VIEW
    
    private func setupBadgeLabel() {
        setupConstraints()
        customizeLabel()
    }
    
    private func setupConstraints() {
        if bounds.size.width > bounds.size.height {
            heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        } else {
            widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
    }
    
    private func customizeLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        text = valueText
        textColor = .white
        textAlignment = .center
        font = .systemFont(ofSize: 14)
        backgroundColor = .red
    }
}
