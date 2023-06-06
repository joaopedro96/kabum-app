//
//  KBHomeView.swift
//  Kabum
//
//  Created by João Pedro Mata on 31/05/23.
//

import UIKit

protocol KBHomeViewDelegate: AnyObject {
    func didTapProduct(with index: Int)
    func getNextProductList(for currentPage: Int)
}

final class KBHomeView: UIView {
    
    // MARK: - PROPERTIES
    
    private var currentProductPage: Int? = 1
    weak var delegate: KBHomeViewDelegate?
    
    // MARK: - INITIALIZER
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let setupComponent = UIScrollView(frame: .zero)
        setupComponent.delegate = self
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.contentInsetAdjustmentBehavior = .never
        setupComponent.showsVerticalScrollIndicator = false
        return setupComponent
    }()
    
    private lazy var containerView: UIStackView = {
        let setupComponent = UIStackView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.axis = .vertical
        return setupComponent
    }()
    
    private lazy var headerSection: KBHomeHeaderSectionView = {
        let setupComponent = KBHomeHeaderSectionView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        return setupComponent
    }()
    
    private lazy var tableSection: KBHomeTableSectionView = {
        let setupComponent = KBHomeTableSectionView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.delegate = self
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    private func updateView(with entity: KBHomeViewEntity) {
        headerSection.updateSection(with: entity)
        tableSection.updateSection(with: entity.tableViewEntity)
    }
    
    private func updateNextPage(with newProducts: [KBHomeTableViewCellEntity]) {
        setCurrentPage(for: newProducts)
        tableSection.updateNextPage(with: newProducts)
    }
    
    ///Update global variable 'currentProductPage' based on product list array size and offset page
    private func setCurrentPage(for products: [KBHomeTableViewCellEntity]) {
        print(products.count)
        if products.count != 10 {
            currentProductPage = nil
        } else {
            currentProductPage! += 1
        }
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        customizeView()
    }
    
    private func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addArrangedSubviews(headerSection, tableSection)
    }
    
    private func addConstraints() {
        let containerViewHeightConstraint = containerView.heightAnchor.constraint(equalTo: heightAnchor)
        containerViewHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerViewHeightConstraint
        ])
    }
    
    private func customizeView() {
        backgroundColor = .gray200
    }
}

// MARK: - EXTENSIONS

extension KBHomeView: KBHomeViewProtocol {
    func updateState(with viewState: KBHomeViewState) {
        switch viewState {
            case .hasData(let data):
                updateView(with: data)
                
            case .hasNextPageData(let data):
                updateNextPage(with: data)
                
            ///Errors should be handled here.
            case .hasError(let error):
                print(error)
                
            case .isLoading:
                tableSection.setFooterView(true)
                
            default: return
        }
    }
}

extension KBHomeView: KBHomeTableSectionViewDelegate {    
    func didTapProduct(with index: Int) {
        delegate?.didTapProduct(with: index)
    }
}

extension KBHomeView: UIScrollViewDelegate {
    
    ///Calculate scroll drag movement to fetch new products. If current page is equal to nil the infinite scroll will stop
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let currentProductPage = currentProductPage else { return }
        let position = scrollView.contentOffset.y
        if position > (containerView.frame.height + 100 - scrollView.frame.size.height) {
            delegate?.getNextProductList(for: currentProductPage)
        }
    }
}
