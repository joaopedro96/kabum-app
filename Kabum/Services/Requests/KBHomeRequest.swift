//
//  KBHomeRequest.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation
import Alamofire

enum KBHomeRequest: KBServiceRequestProtocol {
    
    case home(page: Int)
    case productDetails(url: String)
    
    var path: String {
        switch self {
            case .home: return "/home/v1/home/produto"
            case .productDetails(let url): return url
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
                let params = ["app": 1, "limite": 10, "pagina": page]
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
