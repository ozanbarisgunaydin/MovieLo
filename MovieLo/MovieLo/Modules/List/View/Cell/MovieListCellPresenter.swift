//
//  MovieListCellPresenter.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation

protocol MovieListCellPresenterProtocol: AnyObject {
    func load()
}

final class MovieListCellPresenter {
    
    weak var view: MovieListCellProtocol?
    private let movie: ListResult
    
    init(view: MovieListCellProtocol?, movie: ListResult) {
        self.view = view
        self.movie = movie
    }
}

extension MovieListCellPresenter: MovieListCellPresenterProtocol {
    
    func load() {
        
        if  let image = movie.poster,
            let url = URL(string: image) {
            view?.setMovieImage(url)
        }
        
        if let title = movie.title {
            view?.setTitleLabel(title)
        }
        
        if let date = movie.year  {
            view?.setYearLabel(date)
        }
        
        if let overview = movie.type {
            switch overview {
            case .movie:
                view?.setMovieTypeLabel("Movie")
            case .series:
                view?.setMovieTypeLabel("Serie")

            }
        }
        
    }
    
}
