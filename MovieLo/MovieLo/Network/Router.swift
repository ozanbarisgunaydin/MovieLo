//
//  Router.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let apiKey = "336c418"
    
    case search(query: String?)
    case movieDetail(movieID: Int?)
    
    var baseURL : URL {
        return URL(string: "https://www.omdbapi.com")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .search, .movieDetail:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params: Parameters = [:]
        switch self {
        case .search(query: let query):
            if let query = query {
                params["s"] = query
            }
        case .movieDetail(movieID: let movieID):
            if let movieID = movieID {
                params["movieID"] = movieID
            }
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .search:
            return ""
        case .movieDetail(movieID: let movieID):
            if let movieID = movieID {
                return "movie/\(movieID)"
            }
        }
        return ""
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        
        completeParameters["apiKey"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        print("🐝 Reqeusted URL: ", urlRequestPrint.url ?? "")

        return try encoding.encode(urlRequest, with: completeParameters)
    }
    
}
