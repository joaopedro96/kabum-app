//
//  KBCoverView.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

protocol KBCoverViewDelegate: AnyObject {
    func goToHomePage()
}

final class KBCoverView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: KBCoverViewDelegate?
    
    // MARK: - INITIALIZER
    
    override init(frame: CGRect) {
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
        setupComponent.contentMode = .scaleAspectFit
        setupComponent.image = .logoImage
        return setupComponent
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let setupComponent = UIActivityIndicatorView(style: .large)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.color = .white
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    private func setSpinnerAnimation(_ state: Bool) {
        state ? spinner.startAnimating() : spinner.stopAnimating()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        customizeView()
    }
    
    private func buildViewHierarchy() {
        addSubviews(image, spinner)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 230),
            image.heightAnchor.constraint(equalToConstant: 70),

            spinner.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 60),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func customizeView() {
        backgroundColor = .theme
    }
}

// MARK: - EXTENSIONS

extension KBCoverView: KBCoverViewProtocol {
    func updateState(with viewState: KBCoverViewState) {
        switch viewState {
            ///Errors should be handled here.
            case .hasError:
                return
                
            case .isLoading:
                setSpinnerAnimation(true)
                delegate?.goToHomePage()
            default: return
        }
    }
}
