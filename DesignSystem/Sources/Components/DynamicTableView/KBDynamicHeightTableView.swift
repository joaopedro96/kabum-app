//
//  KBDynamicHeightTableView.swift
//  Kabum
//
//  Created by João Pedro Mata on 31/05/23.
//

import UIKit

public class KBDynamicHeightTableView: UITableView {
    
    override public var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override public var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override public func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
