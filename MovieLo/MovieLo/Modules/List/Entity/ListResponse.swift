//
//  ListResponse.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation

// MARK: - ListReponse
struct ListResponse: Codable {
    
    var searchResult: [ListResult]?
    var totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case searchResult = "Search"
        case totalResults = "totalResult"
        case response = "Response"
    }
}

// MARK: - Search
struct ListResult: Codable {
    var title, year, imdbID: String?
    var type: TypeEnum?
    var poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}
