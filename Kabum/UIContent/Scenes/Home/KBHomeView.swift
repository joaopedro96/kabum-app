//
//  KBHomeView.swift
//  Kabum
//
//  Created by João Pedro Mata on 31/05/23.
//

import UIKit

protocol KBHomeViewDelegate: AnyObject {
    func didTapProduct(with url: String)
    func getNextProductList(for currentPage: Int)
}

final class KBHomeView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: KBHomeViewDelegate?
    private var currentProductPage: Int? = 1
    private var productList: [KBProductObject] = []
    
    // MARK: - INITIALIZER
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .gray200
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
        setupComponent.bounces = true
        setupComponent.scrollsToTop = true
        setupComponent.showsVerticalScrollIndicator = false
        return setupComponent
    }()
    
    private lazy var containerView: UIView = {
        let setupComponent = UIView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        return setupComponent
    }()
    
    private lazy var productTitle: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.text = "PRODUTOS"
        setupComponent.font = .systemFont(ofSize: 12, weight: .regular)
        setupComponent.textColor = .blue200
        return setupComponent
    }()
    
    private lazy var offerTitle: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.text = "Em destaque"
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textColor = .gray500
        return setupComponent
    }()
    
    private lazy var productTableView: KBDynamicHeightTableView = {
        let setupComponent = KBDynamicHeightTableView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.register(KBHomeProductTableViewCell.self,
                                forCellReuseIdentifier: KBHomeProductTableViewCell.identifier)
        setupComponent.showsVerticalScrollIndicator = false
        setupComponent.allowsSelection = true
        setupComponent.separatorColor = .clear
        setupComponent.backgroundColor = .clear
        setupComponent.dataSource = self
        setupComponent.delegate = self
        setupComponent.isScrollEnabled = false
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateView(with dataModel: [KBProductObject]) {
        productList.append(contentsOf: dataModel)
        productTableView.reloadData()
    }
    
    func validateData(with data: [KBProductObject]) {
        if data.count != 10 {
            currentProductPage = nil
        } else {
            currentProductPage! += 1
        }
        updateProductNextPage(with: data)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func updateProductNextPage(with data: [KBProductObject]) {
        guard let indexPathArray = getIndexPathArray(for: data) else { return }
        setFooterView(false)
        productTableView.performBatchUpdates {
            self.productTableView.insertRows(at: indexPathArray, with: .automatic)
        }
    }
    
    private func createSpinnerFooter() -> UIView {
        let screenWidth = UIScreen.main.bounds.width - 12
        let spinnerFooter = CGRect(x: 0, y: 0, width: screenWidth, height: 100)
        let footerView = UIView(frame: spinnerFooter)
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
        
    private func setFooterView(_ state: Bool) {
        if state {
            productTableView.tableFooterView = createSpinnerFooter()
        } else {
            productTableView.tableFooterView = nil
        }
    }
    
    private func getIndexPathArray(for newData: [KBProductObject]) -> [IndexPath]? {
        let currentIndex = productList.count
        productList.append(contentsOf: newData)
        let newCount = productList.count
        var indexPathArray: [IndexPath] = []

        for index in currentIndex ..< newCount {
            indexPathArray.append(IndexPath(row: index, section: 0))
        }

        return indexPathArray
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(productTitle, offerTitle, productTableView)
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
            containerViewHeightConstraint,
            
            productTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            productTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            productTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            offerTitle.topAnchor.constraint(equalTo: productTitle.bottomAnchor),
            offerTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            offerTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            productTableView.topAnchor.constraint(equalTo: offerTitle.bottomAnchor, constant: 24),
            productTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            productTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            productTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

// MARK: - EXTENSIONS

extension KBHomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KBHomeProductTableViewCell.identifier, for: indexPath)
        guard let episodeCell = cell as? KBHomeProductTableViewCell else { return cell }
        episodeCell.updateCell(with: productList[indexPath.row])
        return episodeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapProduct(with: productList[indexPath.row].descriptionUrl)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.contentView.layer.shadowPath = UIBezierPath(roundedRect: cell.contentView.bounds, cornerRadius: radius).cgPath
    }
}

extension KBHomeView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let currentProductPage = currentProductPage else { return }
        let position = scrollView.contentOffset.y
        if position > (containerView.frame.height + 100 - scrollView.frame.size.height) {
            setFooterView(true)
            delegate?.getNextProductList(for: currentProductPage)
        }
    }
}
