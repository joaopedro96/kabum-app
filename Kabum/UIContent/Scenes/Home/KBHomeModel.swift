//
//  KBHomeResponse.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation

struct CellModel {
    
    let image: String
    
    //tag Oferta Ninja
    let offer: KBOfferObject?
    
    //tag Prime Ninja
    let discountPrice: String
    let primeDiscountPrice: String

    //tag Open Box
    let isOpenBox: Bool
    
    let manufacturer: KBManufacturerObject //name capitalized

    let name: String // nome produto
    
    let formattedDiscountPrice: String // isPrime ? formattedPrimeDiscountPrice : formattedDiscountPrice
    
    let formattedPrice: String // em até 10x
}

struct KBHomeModel: Codable {
    let success: Bool
    let products: [KBProductObject]
    
    enum CodingKeys: String, CodingKey {
        case success = "sucesso"
        case products = "produtos"
    }
}

struct KBProductObject: Codable {
    let code: Int
    let image: String
    let name: String
    let alt: Int
    let freeShipping: Bool
    let primeFreeShipping: Bool
    let descriptionUrl: String
    let oldPrice: String
    let price: String
    let primePrice: String
    let discountPrice: String
    let primeDiscountPrice: String
    let formattedPrice: String
    let formattedPrimePrice: String
    let formattedDiscountPrice: String
    let formattedPrimeDiscountPrice: String
    let reviewNumber: Int
    let reviewRate: Int
    let isOpenBox: Bool
    let manufacturer: KBManufacturerObject
    let menu: String
    let inStock: Bool
    let offer: KBOfferObject?
    let sellerName: String
    let offerId: String
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
        case offerId = "offer_id"
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
