//
//  KBRequest.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation
import Alamofire

enum KBRequest: KBServiceRequestProtocol {
    
    static let basePath = "https://servicespub.prod.api.aws.grupokabum.com.br"
    static let firstHomePage = 1
    static let homePageProductsOffset = 10
    
    case home(page: Int)
    case description(url: String)
    
    var path: String {
        switch self {
            case .home: return "\(KBRequest.basePath)/home/v1/home/produto"
            case .description(let url): return "\(KBRequest.basePath)\(url)"
        }
    }

    var method: HTTPMethod {
        switch self {
            default: return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
            case .home(let page):
                let params = ["app": 1, "limite": KBRequest.homePageProductsOffset, "pagina": page]
                return params
            default: return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            default: return nil
        }
    }
}

