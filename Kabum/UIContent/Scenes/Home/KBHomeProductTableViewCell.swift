//
//  KBHomeProductTableViewCell.swift
//  Kabum
//
//  Created by João Pedro Mata on 31/05/23.
//

import UIKit

final class KBHomeProductTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    static let identifier = "KBHomeProductTableViewCell"
    
    // MARK: - INITIALIZER
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        manufacturerLabel.text = nil
        nameLabel.text = nil
        discountPriceLabel.text = nil
        installmentPriceLabel.text = nil
        favoriteButton.isSelected = false
        shoppingCartButton.isSelected = false
        tagStackView.removeSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8))
    }
    
    // MARK: - UI
    
    private lazy var imageContainerView: UIView = {
        let setupComponent = UIView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.layer.cornerRadius = 12
        setupComponent.backgroundColor = .white
        setupComponent.layer.masksToBounds = false
        setupComponent.layer.shadowOpacity = 0.1
        setupComponent.layer.shadowRadius = 2
        setupComponent.layer.shadowOffset = CGSize(width: 0, height: 0)
        setupComponent.layer.shadowColor = UIColor.black.cgColor
        return setupComponent
    }()
    
    private lazy var productImage: UIImageView = {
        let setupComponent = UIImageView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.backgroundColor = .white
        setupComponent.clipsToBounds = true
        return setupComponent
    }()
    
    private lazy var tagStackView: UIStackView = {
        let setupComponent = UIStackView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.axis = .horizontal
        setupComponent.alignment = .leading
        setupComponent.spacing = 4
        return setupComponent
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let setupComponent = UIStackView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.axis = .horizontal
        setupComponent.distribution = .fill
        setupComponent.spacing = 12
        return setupComponent
    }()
    
    private lazy var manufacturerLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 12, weight: .regular)
        setupComponent.textColor = .gray300
        return setupComponent
    }()
    
    private lazy var nameLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 3
        setupComponent.font = .systemFont(ofSize: 14, weight: .bold)
        setupComponent.lineBreakMode = .byClipping
        setupComponent.textColor = .gray500
        return setupComponent
    }()
    
    private lazy var discountPriceLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 20, weight: .bold)
        setupComponent.textColor = .orange500
        return setupComponent
    }()
    
    private lazy var installmentPriceLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 12, weight: .regular)
        setupComponent.textColor = .gray300
        return setupComponent
    }()
    
    private lazy var buyButton: UIButton = {
        let setupComponent = UIButton(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.layer.cornerRadius = 4
        setupComponent.setTitle("Comprar", for: .normal)
        setupComponent.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        setupComponent.backgroundColor = .orange500
        setupComponent.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        return setupComponent
    }()
    
    private lazy var favoriteButton: UIButton = {
        let normalImage =  UIImage(systemName: "heart.fill")?.withTintColor(.gray400, renderingMode: .alwaysOriginal)
        let selectedImage = UIImage(systemName: "heart.fill")?.withTintColor(.orange500, renderingMode: .alwaysOriginal)
        let setupComponent = UIButton(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.setImage(normalImage, for: .normal)
        setupComponent.setImage(selectedImage, for: .selected)
        setupComponent.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        setupComponent.heightAnchor.constraint(equalToConstant: 20).isActive = true
        setupComponent.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return setupComponent
    }()
    
    private lazy var shoppingCartButton: UIButton = {
        let normalImage =  UIImage(systemName: "cart.fill")?.withTintColor(.gray400, renderingMode: .alwaysOriginal)
        let selectedImage = UIImage(systemName: "cart.fill")?.withTintColor(.orange500, renderingMode: .alwaysOriginal)
        let setupComponent = UIButton(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.setImage(normalImage, for: .normal)
        setupComponent.setImage(selectedImage, for: .selected)
        setupComponent.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        setupComponent.heightAnchor.constraint(equalToConstant: 20).isActive = true
        setupComponent.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateCell(with cellData: KBProductObject) {
        updateProductImage(with: cellData.image)
        manufacturerLabel.text = cellData.manufacturer.name.uppercased()
        nameLabel.text = cellData.name
        discountPriceLabel.text = cellData.formattedDiscountPrice
        installmentPriceLabel.text = "\(cellData.formattedPrice) em até 10x"
        setTags(with: cellData)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setTags(with cellData: KBProductObject) {
        checkPrimeTag(for: cellData.discountPrice, and: cellData.primeDiscountPrice)
        checkNinjaTag(for: cellData.offer)
        checkBoxTag(for: cellData.isOpenBox)
    }
    
    private func checkPrimeTag(for discountPrice: String, and primeDiscountPrice: String) {
        if primeDiscountPrice < discountPrice && primeDiscountPrice != "0.00" {
            makeTag(with: .primeIcon)
        }
    }
    
    private func checkNinjaTag(for offerObject: KBOfferObject?) {
        if offerObject?.event != nil {
            makeTag(with: .ninjaIcon)
        }
    }
    
    private func checkBoxTag(for isOpenBox: Bool) {
        if isOpenBox {
            makeTag(with: .boxIcon)
        }
    }
    
    private func makeTag(with icon: UIImage?) {
        let tagIcon = UIImageView()
        tagIcon.image = icon
        tagIcon.translatesAutoresizingMaskIntoConstraints = false
        tagIcon.contentMode = .scaleAspectFit
        tagIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        tagIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        tagStackView.addArrangedSubview(tagIcon)
    }
    
    private func updateProductImage(with urlString: String) {
        DispatchQueue.global().async {
            guard let loadedImage = self.getImage(from: urlString) else { return }
            DispatchQueue.main.async {
                self.productImage.image = loadedImage
            }
        }
    }
    
    private func getImage(from urlString: String) -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: imageData)
    }
    
    @objc private func didTapBuyButton() {
        print("buy button tapped")
    }
    
    @objc private func didTapFavoriteButton() {
        favoriteButton.isSelected.toggle()
        print("favorite button tapped")
    }

    @objc private func didTapCartButton() {
        shoppingCartButton.isSelected.toggle()
        print("shopping cart button tapped")
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        setupImageContainerView()
        buildViewHierarchy()
        addConstraints()
        customizeView()
    }
    
    private func setupImageContainerView() {
        imageContainerView.addSubviews(tagStackView, productImage)
        
        let tagStackViewTrailing = tagStackView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -24)
        tagStackViewTrailing.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            tagStackView.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 4),
            tagStackView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 24),
            tagStackViewTrailing,
            
            productImage.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            productImage.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 130),
            productImage.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func buildViewHierarchy() {
        contentView.addSubviews(imageContainerView,
                                manufacturerLabel,
                                nameLabel,
                                discountPriceLabel,
                                installmentPriceLabel,
                                horizontalStackView)
        horizontalStackView.addArrangedSubviews(buyButton, favoriteButton, shoppingCartButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            manufacturerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            manufacturerLabel.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: 8),
            manufacturerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: manufacturerLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: manufacturerLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: manufacturerLabel.trailingAnchor),
            
            discountPriceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            discountPriceLabel.leadingAnchor.constraint(equalTo: manufacturerLabel.leadingAnchor),
            discountPriceLabel.trailingAnchor.constraint(equalTo: manufacturerLabel.trailingAnchor),
            
            installmentPriceLabel.topAnchor.constraint(equalTo: discountPriceLabel.bottomAnchor),
            installmentPriceLabel.leadingAnchor.constraint(equalTo: manufacturerLabel.leadingAnchor),
            installmentPriceLabel.trailingAnchor.constraint(equalTo: manufacturerLabel.trailingAnchor),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: manufacturerLabel.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: manufacturerLabel.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private func customizeView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .gray100
        contentView.layer.cornerRadius = 8
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
}
