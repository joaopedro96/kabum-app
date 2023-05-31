//
//  KBServiceManager.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation
import Alamofire

final class KBServiceManager: KBServiceManagerProtocol {
    
    static let shared = KBServiceManager()
    
    func execute<T: Decodable>(request: KBServiceRequestProtocol,
                               completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(request.path,
                   method: request.method,
                   parameters: request.parameters,
                   headers: request.headers).response { response in
            switch response.result {
                    
                case .success(let data):
                    guard let data = data else { return }
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
