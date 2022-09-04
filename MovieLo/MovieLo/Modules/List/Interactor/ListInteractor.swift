//
//  ListInteractor.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation

protocol ListInteractorProtocol: AnyObject {
    func fetchMoviesWith(searchText: String)
}

protocol ListInteractorOutputProtocol: AnyObject {
    func recievedMovies(result: MovieListResult)
}

typealias MovieListResult = Result<ListResponse, Error>
fileprivate var movieService: MovieServiceProtocol = MovieService()

final class ListInteractor {
    var output: ListInteractorOutputProtocol?
}

extension ListInteractor: ListInteractorProtocol {
    
    func fetchMoviesWith(searchText: String) {
        movieService.fetchSearch(query: searchText, completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.output?.recievedMovies(result: result)
        })
    }
    
}
