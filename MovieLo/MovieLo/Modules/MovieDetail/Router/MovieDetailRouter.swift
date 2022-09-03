//
//  MovieDetailRouter.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 4.09.2022.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol: AnyObject {
    func navigate(_ route: MovieDetailRoutes)
}

enum MovieDetailRoutes {
    case openURL(imdbId: String)
}

final class MovieDetailRouter {
    
    weak var viewController: MovieDetailViewController?
    
    static func createModule(movieID: String) -> MovieDetailViewController {
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(view: view, router: router, interactor: interactor, movieID: movieID)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension MovieDetailRouter: MovieDetailRouterProtocol {
    
    func navigate(_ route: MovieDetailRoutes) {
        switch route {
        
        case .openURL(let imdbId):
            if let url = URL(string: "https://www.imdb.com/title/" + imdbId) {
                UIApplication.shared.open(url)
            }
        }
    }
}
