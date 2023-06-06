//
//  KBNavigationSearchBarView.swift
//  Kabum
//
//  Created by João Pedro Mata on 05/06/23.
//

import UIKit

protocol KBNavigationSearchBarDelegate: AnyObject {
    func didTapNavigationSearchBar()
    func didTapClear()
    func didMakeSearch(for text: String)
}

extension KBNavigationSearchBarDelegate {
    func didTapNavigationSearchBar() { }
    func didTapClear() { }
    func didMakeSearch(for text: String) { }
}

final class KBNavigationSearchBarView: UIView {
    
    // MARK: - PROPERTIES
    
    private var isEditingSearchBar: Bool = false
    var delegate: KBNavigationSearchBarDelegate?
    
    // MARK: - INITALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var searchTextField: UITextField = {
        let setupComponent = UITextField(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.leftView = setTextFieldPadding(with: 36)
        setupComponent.rightView = setTextFieldPadding(with: 32)
        setupComponent.leftViewMode = .always
        setupComponent.rightViewMode = .always
        setupComponent.backgroundColor = .white
        setupComponent.textColor = .gray400
        setupComponent.font = .systemFont(ofSize: 16, weight: .regular)
        setupComponent.layer.cornerRadius = 8
        setupComponent.delegate = self
        setupComponent.attributedPlaceholder = NSAttributedString(
            string: "Procure no KaBuM!",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray300])
        setupComponent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTextField)))
        return setupComponent
    }()
    
    private lazy var searchIcon: UIImageView = {
        let setupComponent = UIImageView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.image = .searchIcon.withTintColor(.gray300)
        setupComponent.contentMode = .scaleToFill
        return setupComponent
    }()
    
    private lazy var cancelIcon: UIImageView = {
        let setupComponent = UIImageView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.image = .cancelIcon.withTintColor(.gray300)
        setupComponent.contentMode = .scaleToFill
        setupComponent.isHidden = true
        setupComponent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapClear)))
        setupComponent.isUserInteractionEnabled = true
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func closeKeyboard() {
        if isEditingSearchBar {
            searchTextField.endEditing(true)
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setTextFieldPadding(with padding: Double) -> UIView {
        let viewPadding = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: 2))
        return viewPadding
    }
    
    @objc private func didTapClear() {
        searchTextField.text = ""
        cancelIcon.isHidden = true
        delegate?.didTapClear()
    }
    
    @objc private func didTapTextField() {
        searchTextField.endEditing(true)
        delegate?.didTapNavigationSearchBar()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(searchTextField)
        addSubview(searchIcon)
        addSubview(cancelIcon)
    }
    
    private func addConstraints() {
        let maxWidth = searchTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        maxWidth.priority = .defaultHigh

        let maxHeight = searchTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
        maxHeight.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            maxWidth,
            maxHeight,
            
            searchIcon.topAnchor.constraint(equalTo: searchTextField.topAnchor, constant: 4),
            searchIcon.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: 8),
            searchIcon.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: -4),
            searchIcon.widthAnchor.constraint(equalToConstant: 24),

            cancelIcon.topAnchor.constraint(equalTo: searchTextField.topAnchor, constant: 4),
            cancelIcon.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: -8),
            cancelIcon.widthAnchor.constraint(equalToConstant: 24),
            cancelIcon.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: -4)
        ])
    }
}

// MARK: - EXTENSIONS

extension KBNavigationSearchBarView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            cancelIcon.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            guard let currentText = textField.text else { return true }
            let maskText = currentText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+").folding(options: .diacriticInsensitive, locale: .current)
            delegate?.didMakeSearch(for: maskText)
        } else {
            didTapClear()
        }
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            cancelIcon.isHidden = true
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isEditingSearchBar = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEditingSearchBar = false
    }
}
