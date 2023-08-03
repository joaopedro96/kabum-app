//
//  KBHomeViewEntity.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import Foundation

public struct KBHomeViewEntity {
    let sectionTitle: String
    let offerTitle: String
    let tableViewEntity: [KBHomeTableViewCellEntity]
}

public struct KBHomeTableViewCellEntity {
    let name: String
    let image: String
    let manufacturerName: String
    let formattedPrice: String
    let formattedDiscountPrice: String
    let discountPrice: String
    let primeDiscountPrice: String
    let buyButtonTitle: String
    let isOffer: Bool
    let isOpenBox: Bool
    let isFreeShipping: Bool
}
