//
//  NetworkManager.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    
    let reachabilityManager = NetworkReachabilityManager()?.isReachable
    
    func isConnectedToInternet() -> Bool {
        return reachabilityManager ?? false
    }
    
    func request<T: Codable>(_ request: URLRequestConvertible,
                             decodeToType type: T.Type,
                             completionHandler: @escaping (Result<T,Error>) -> ()) {
        AF.request(request).responseData { response in
            
            switch response.result {
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(type.self, from: data)
                    completionHandler(.success(result))
                    self.printResponse(response: response)
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// Prints the reponse data for log screen.
    private func printResponse(response: AFDataResponse<Data>) {
        if let data = response.data,
           let json = String(data: data, encoding: String.Encoding.utf8) {
            print("\n🌵 Success Response: \(json) \n")
        }
    }
}
