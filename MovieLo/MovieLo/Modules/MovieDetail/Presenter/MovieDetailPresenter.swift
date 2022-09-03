//
//  MovieDetailPresenter.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 4.09.2022.
//

import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func loadInputViews()
    func goToImdbPage()
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    unowned var view: MovieDetailViewControllerProtocol?
    let router: MovieDetailRouterProtocol!
    let interactor: MovieDetailInteractorProtocol!
    let movieID: String
    
    private var movieDetail: MovieDetailResponse?
    
    init(
        view: MovieDetailViewControllerProtocol,
        router: MovieDetailRouterProtocol,
        interactor: MovieDetailInteractorProtocol,
        movieID: String
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.movieID = movieID
    }
    
    func viewDidLoad() {
        fetchMovieDetail(with: self.movieID)
    }
    
    func loadInputViews() {
        
        if  let image = movieDetail?.poster,
            let url = URL(string: image) {
            view?.setMoviePoster(url)
        }
        
        if let title = movieDetail?.title {
            view?.setMovieTitle(title)
        }
        
        if let date = movieDetail?.released  {
            view?.setReleaseDate(date)
        }
        
        if let voteAverage = movieDetail?.imdbRating {
            view?.setVoteScore("\(voteAverage)")
        }
        
        if let overview = movieDetail?.plot {
            view?.setMovieDescription(overview)
        }
        
        if let _ = movieDetail?.imdbID {
            view?.setImdbAvaibleView()
        }
    
    }
    
    func goToImdbPage() {
        router.navigate(.openURL(imdbId: self.movieID))
        
    }
    
    private func fetchMovieDetail(with movieId: String) {
        view?.showLoadingView()
        interactor.fetchMovieDetail(movieId)
    }
    
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    
    func fetchMovieDetail(result: MovieDetailResult) {
        view?.hideLoadingView()
        
        switch result {
        case .success(let movieDetail):
            
            self.movieDetail = movieDetail
            view?.reloadData()
            
        case .failure(let error):
            print(error)
        }
    }
    
}
