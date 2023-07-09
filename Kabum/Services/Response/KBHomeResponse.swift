//
//  KBHomeResponse.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation

struct KBHomeResponse: Codable {
    var products: [KBProductObject]
    
    ///All the attributes listed below wont be used in this project. They are only shown to demonstrate how they should be declared
    let success: Bool
    let blackFridayFlag: Int
    
    enum CodingKeys: String, CodingKey {
        case success = "sucesso"
        case blackFridayFlag = "flag_blackfriday"
        case products = "produtos"
    }
}

struct KBProductObject: Codable {
    let name: String
    let image: String
    let offer: KBOfferObject?
    let discountPrice: String
    let formattedPrice: String
    let primeDiscountPrice: String
    let formattedDiscountPrice: String
    let manufacturer: KBManufacturerObject
    let isOpenBox: Bool
    let freeShipping: Bool

    ///All the attributes listed below wont be used in this project. They are only shown to demonstrate how they should be declared
    let code: Int
    let alt: Int
    let primeFreeShipping: Bool
    let descriptionUrl: String
    let oldPrice: String
    let price: String
    let primePrice: String
    let formattedPrimePrice: String
    let formattedPrimeDiscountPrice: String
    let reviewNumber: Int
    let reviewRate: Int
    let menu: String
    let inStock: Bool
    let sellerName: String
    let sellerId: Int
    let discountPct: String
    
    enum CodingKeys: String, CodingKey {
        case code = "codigo"
        case image = "img"
        case name = "nome"
        case alt
        case freeShipping = "tem_frete_gratis"
        case primeFreeShipping = "frete_gratis_somente_prime"
        case descriptionUrl = "link_descricao"
        case oldPrice = "preco_antigo"
        case price = "preco"
        case primePrice = "preco_prime"
        case discountPrice = "preco_desconto"
        case primeDiscountPrice = "preco_desconto_prime"
        case formattedPrice = "preco_formatado"
        case formattedPrimePrice = "preco_prime_formatado"
        case formattedDiscountPrice = "preco_desconto_formatado"
        case formattedPrimeDiscountPrice = "preco_desconto_prime_formatado"
        case reviewNumber = "avaliacao_numero"
        case reviewRate = "avaliacao_nota"
        case isOpenBox = "is_openbox"
        case manufacturer = "fabricante"
        case menu
        case inStock = "disponibilidade"
        case offer = "oferta"
        case sellerName = "vendedor_nome"
        case sellerId = "id_seller"
        case discountPct = "porcentagem_desconto"
    }
}

struct KBManufacturerObject: Codable {
    let code: Int
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case code = "codigo"
        case name = "nome"
        case image = "img"
    }
}

struct KBOfferObject: Codable {
    let code: String?
    let di: String?
    let codeEvent: Int?
    let startDate: Int?
    let endDate: Int?
    let quantity: Int?
    let event: String?
    let signIn: Int?
    
    enum CodingKeys: String, CodingKey {
        case code = "codigo"
        case di
        case codeEvent = "evento_codigo"
        case startDate = "data_inicio"
        case endDate = "data_fim"
        case quantity = "quantidade"
        case event = "evento"
        case signIn = "logar"
    }
}
