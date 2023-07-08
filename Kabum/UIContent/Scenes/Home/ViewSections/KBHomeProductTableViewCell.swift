//
//  KBHomeProductTableViewCell.swift
//  Kabum
//
//  Created by João Pedro Mata on 31/05/23.
//

import Kingfisher
import UIKit

protocol KBHomeProductTableViewCellDelegate: AnyObject {
    func didTapBuyButton()
    func didTapFavoriteButton(with state: Bool, and index: Int)
    func didTapShoppingCartButton(with state: Bool, and index: Int)
}

final class KBHomeProductTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    static let identifier = "KBHomeProductTableViewCell"
    weak var delegate: KBHomeProductTableViewCellDelegate?
    var cellIndex: Int = 0
    
    // MARK: - INITIALIZER
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
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
    
    ///Set cell padding and apllied it to contentView frame when layoutSubview its called
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8))
    }
    
    ///Insert gradient background when layout sublayers its called
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        backgroundGradient.frame = contentView.bounds
        contentView.layer.insertSublayer(backgroundGradient, at: 0)
    }
    
    // MARK: - UI
    
    private lazy var backgroundGradient: CAGradientLayer = {
        let setupComponent = CAGradientLayer()
        setupComponent.type = .axial
        setupComponent.colors = [UIColor.white.cgColor, UIColor.gray200.cgColor]
        setupComponent.startPoint = CGPoint(x: 0, y: 0)
        setupComponent.endPoint = CGPoint(x: 1, y: 1)
        setupComponent.locations = [0, 1]
        return setupComponent
    }()
    
    private lazy var imageContainerView: UIView = {
        let setupComponent = UIView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.backgroundColor = .white
        setupComponent.layer.cornerRadius = 12
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
        setupComponent.lineBreakMode = .byWordWrapping
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
        setupComponent.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        setupComponent.backgroundColor = .orange500
        setupComponent.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        return setupComponent
    }()
    
    private lazy var favoriteButton: UIButton = {
        let setupComponent = UIButton(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.setImage(.heartIcon.withTintColor(.gray400), for: .normal)
        setupComponent.setImage(.heartIcon.withTintColor(.orange500), for: .selected)
        setupComponent.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        setupComponent.heightAnchor.constraint(equalToConstant: 20).isActive = true
        setupComponent.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return setupComponent
    }()
    
    private lazy var shoppingCartButton: UIButton = {
        let setupComponent = UIButton(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.setImage(.cartIcon.withTintColor(.gray400), for: .normal)
        setupComponent.setImage(.cartIcon.withTintColor(.orange500), for: .selected)
        setupComponent.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        setupComponent.heightAnchor.constraint(equalToConstant: 20).isActive = true
        setupComponent.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateCell(with cellEntity: KBHomeTableViewCellEntity) {
        updateProductImage(with: cellEntity.image)
        manufacturerLabel.text = cellEntity.manufacturerName.uppercased()
        nameLabel.text = cellEntity.name
        discountPriceLabel.text = cellEntity.discountPrice.toCurrency()
        installmentPriceLabel.text = cellEntity.formattedPrice
        buyButton.setTitle(cellEntity.buyButtonTitle, for: .normal)
        setTags(with: cellEntity)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setTags(with cellEntity: KBHomeTableViewCellEntity) {
        checkPrimeTag(for: cellEntity.discountPrice, and: cellEntity.primeDiscountPrice)
        checkNinjaTag(for: cellEntity.isOffer)
        checkShippingTag(for: cellEntity.isFreeShipping)
        checkBoxTag(for: cellEntity.isOpenBox)
    }
    
    private func checkPrimeTag(for discountPrice: String, and primeDiscountPrice: String) {
        guard let primeDiscountPrice = Double(primeDiscountPrice),
              let discountPrice = Double(discountPrice) else { return }
        
        if (primeDiscountPrice < discountPrice) && (primeDiscountPrice != 0.00) {
            makeTag(with: .primeIcon)
        }
    }
    
    private func checkNinjaTag(for isOffer: Bool) {
        if isOffer {
            makeTag(with: .ninjaIcon)
        }
    }
    
    private func checkShippingTag(for isFreeShipping: Bool) {
        if isFreeShipping {
            makeTag(with: .shippingIcon)
        }
    }
    
    private func checkBoxTag(for isOpenBox: Bool) {
        if isOpenBox {
            makeTag(with: .boxIcon)
        }
    }
    
    private func makeTag(with icon: UIImage?) {
        let tagIcon = UIImageView()
        tagIcon.translatesAutoresizingMaskIntoConstraints = false
        tagIcon.contentMode = .scaleAspectFit
        tagIcon.image = icon
        tagIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        tagIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        tagStackView.addArrangedSubview(tagIcon)
    }
    
    private func updateProductImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        productImage.kf.setImage(with: url)
    }
    
    @objc private func didTapBuyButton() {
        delegate?.didTapBuyButton()
    }
    
    @objc private func didTapFavoriteButton() {
        favoriteButton.isSelected.toggle()
        delegate?.didTapFavoriteButton(with: favoriteButton.isSelected, and: cellIndex)
    }

    @objc private func didTapCartButton() {
        shoppingCartButton.isSelected.toggle()
        delegate?.didTapShoppingCartButton(with: shoppingCartButton.isSelected, and: cellIndex)
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        setupImageContainerView()
        buildViewHierarchy()
        addConstraints()
        customizeView()
    }
    
    private func setupImageContainerView() {
        imageContainerView.addSubviews(productImage, tagStackView)
        
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
        contentView.layer.cornerRadius = 8
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
}
