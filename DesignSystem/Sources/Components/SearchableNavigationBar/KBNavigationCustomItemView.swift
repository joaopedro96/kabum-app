//
//  KBNavigationCustomItemView.swift
//  Kabum
//
//  Created by João Pedro Mata on 05/06/23.
//

import UIKit

public protocol KBNavigationBarCustomItemViewDelegate: AnyObject {
    func didTapNavigationItem()
}

final public class KBNavigationCustomItemView: UIView {
    
    // MARK: - PROPERTIES
    
    private let icon: UIImage
    public weak var delegate: KBNavigationBarCustomItemViewDelegate?
    
    // MARK: - INITIALIZER
        
    public init(icon: UIImage = .cartIcon) {
        self.icon = icon
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var image: UIImageView = {
        let setupComponent = UIImageView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.image = icon.withTintColor(.white)
        setupComponent.contentMode = .scaleAspectFit
        setupComponent.isUserInteractionEnabled = true
        setupComponent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapImage() {
        delegate?.didTapNavigationItem()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(image)
    }
    
    private func addConstraints() {
        let maxWidth = image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.1)
        maxWidth.priority = .required
        
        let maxHeight = image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.1)
        maxHeight.priority = .required
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            maxHeight,
            maxWidth
        ])
    }
}
