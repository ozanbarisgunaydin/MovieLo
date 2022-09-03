//
//  ServiceManager.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchSearch(query: String, completionHandler: @escaping (MovieListResult) -> ())
    func fetchMovieDetail(movieID: String, completionHandler: @escaping (MovieDetailResult) -> ())
}

struct MovieService: MovieServiceProtocol {

    func fetchSearch(query: String, completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.request(Router.search(query: query), decodeToType: ListResponse.self, completionHandler: completionHandler)
    }
    
    func fetchMovieDetail(movieID: String, completionHandler: @escaping (MovieDetailResult) -> ()) {
        NetworkManager.shared.request(Router.movieDetail(movieID: movieID), decodeToType: MovieDetailResponse.self, completionHandler: completionHandler)
    }

}
