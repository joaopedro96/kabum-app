//
//  KBHomeHeaderSectionView.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import UIKit

final class KBHomeHeaderSectionView: UIView {
    
    // MARK: - INITIALIZER
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var sectionTitle: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 12, weight: .regular)
        setupComponent.textColor = .blue200
        return setupComponent
    }()
    
    private lazy var offerTitle: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textColor = .gray500
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateSection(with entity: KBHomeViewEntity) {
        sectionTitle.text = entity.sectionTitle.uppercased()
        offerTitle.text = entity.offerTitle
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubviews(sectionTitle, offerTitle)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            offerTitle.topAnchor.constraint(equalTo: sectionTitle.bottomAnchor),
            offerTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            offerTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            offerTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
