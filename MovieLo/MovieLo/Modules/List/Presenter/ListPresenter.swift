//
//  ListPresenter.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfItems() -> Int
    func movie(_ index: Int) -> ListResult?
    func didSelectRowAt(index: Int)
    func searchMovie(searchText: String)
    func clearData()
}

final class ListPresenter: ListPresenterProtocol {
    
    unowned var view: ListViewControllerProtocol?
    let router: ListRouterProtocol!
    let interactor: ListInteractorProtocol!
    
    private var movies: [ListResult] = []
    
    init(
        view: ListViewControllerProtocol,
        router: ListRouterProtocol,
        interactor: ListInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        view?.setupSearchView()
    }
    
    func viewWillAppear() {
        view?.setUpView()
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func movie(_ index: Int) -> ListResult? {
        return movies[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = movie(index) else { return }
        router.navigate(.detail(movieId: movie.imdbID))
    }
    
    func searchMovie(searchText: String) {
        view?.showLoadingView()
        interactor.fetchMoviesWith(searchText: searchText)
    }
    
    func clearData() {
        self.movies = []
    }

}

extension ListPresenter: ListInteractorOutputProtocol {
    
    func recievedMovies(result: MovieListResult) {
        view?.hideLoadingView()
        
        switch result {
        case .success(let moviesResult):
            if let movies = moviesResult.searchResult {
                self.movies = movies
                view?.showNeededScreen(hasData: true)
                view?.reloadData()
            } else {
                print("\n🚨 Mapping error occured")
                view?.showNeededScreen(hasData: false)
            }
        case .failure(let error):
            print("\n🚨", error.localizedDescription)
            view?.showNeededScreen(hasData: false)
        }
    }
    
}
