//
//  KBServiceManager.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation
import Alamofire

public final class KBServiceManager: KBServiceManagerProtocol {
    
    // MARK: - PUBLIC METHODS
    
    func execute<T: Decodable>(request: KBServiceRequestProtocol,
                               completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(request.url,
                   method: request.method,
                   parameters: request.parameters,
                   headers: request.headers).validate().response { [weak self] response in
            switch response.result {
                case .success(let data):
                    guard let data = data else { return }
                    self?.logRequest(with: response, data: data)
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        self?.logParseError(for: error)
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    self?.logRequest(with: response, error: error)
                    completion(.failure(error))
            }
        }
    }
    
    func getStatusCode(request: KBServiceRequestProtocol, completion: @escaping ((Int?) -> Void)) {
        AF.request(request.url,
                   method: request.method,
                   parameters: request.parameters,
                   headers: request.headers).response { response in
            completion(response.response?.statusCode)
        }
    }
}
