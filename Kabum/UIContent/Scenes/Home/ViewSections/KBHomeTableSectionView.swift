//
//  KBHomeTableSectionView.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import UIKit

protocol KBHomeTableSectionViewDelegate: AnyObject {
    func didTapProduct(with index: Int)
}

final class KBHomeTableSectionView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: KBHomeTableSectionViewDelegate?
    private var productList: [KBHomeTableViewCellEntity] = []
    
    // MARK: - INITIALIZER
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var productTableView: KBDynamicHeightTableView = {
        let setupComponent = KBDynamicHeightTableView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.register(KBHomeProductTableViewCell.self,
                                forCellReuseIdentifier: KBHomeProductTableViewCell.identifier)
        setupComponent.showsVerticalScrollIndicator = false
        setupComponent.separatorColor = .clear
        setupComponent.backgroundColor = .clear
        setupComponent.dataSource = self
        setupComponent.delegate = self
        setupComponent.isScrollEnabled = false
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateSection(with entity: [KBHomeTableViewCellEntity]) {
        productList.append(contentsOf: entity)
        productTableView.reloadData()
    }
    
    func updateNextPage(with newProducts: [KBHomeTableViewCellEntity]) {
        setFooterView(false)
        guard let indexPathArray = getIndexPathArray(for: newProducts) else { return }
        productTableView.performBatchUpdates {
            self.productTableView.insertRows(at: indexPathArray, with: .automatic)
        }
    }
    
    func setFooterView(_ state: Bool) {
        productTableView.tableFooterView = state ? createSpinnerFooter() : nil
    }
    
    // MARK: - PRIVATE METHODS
    
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
    
    ///Generate index path array to insert new rows of products in each of them
    private func getIndexPathArray(for newData: [KBHomeTableViewCellEntity]) -> [IndexPath]? {
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
        addSubview(productTableView)
    }
    
    private func addConstraints() {
        productTableView.constraintToSuperview(top: 24)
    }
}

// MARK: - EXTENSIONS

extension KBHomeTableSectionView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KBHomeProductTableViewCell.identifier, for: indexPath)
        guard let productCell = cell as? KBHomeProductTableViewCell else { return cell }
        productCell.updateCell(with: productList[indexPath.row])
        return productCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapProduct(with: indexPath.row)
    }
    
    ///Define cell shadow path and fit cell to its bounds to apply radius layout
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.contentView.layer.shadowPath = UIBezierPath(roundedRect: cell.contentView.bounds, cornerRadius: radius).cgPath
    }
}
