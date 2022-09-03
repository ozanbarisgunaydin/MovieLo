//
//  MovieDetailInteractor.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 4.09.2022.
//

import Foundation

protocol MovieDetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(_ movieId: String)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func fetchMovieDetail(result: MovieDetailResult)
}

typealias MovieDetailResult = Result<MovieDetailResponse, Error>

fileprivate var movieService: MovieServiceProtocol = MovieService()

final class MovieDetailInteractor {
    var output: MovieDetailInteractorOutputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    func fetchMovieDetail(_ movieId: String) {
        movieService.fetchMovieDetail(movieID: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieDetail(result: result)
        }
    }
    
}
