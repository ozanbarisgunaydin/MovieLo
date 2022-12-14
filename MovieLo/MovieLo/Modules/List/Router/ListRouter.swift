//
//  ListRouter.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import UIKit

protocol ListRouterProtocol: AnyObject {
    func navigate(_ route: ListRoutes)
}

enum ListRoutes {
    case detail(movieId: String?)
}

final class ListRouter {
    
    weak var viewController: ListViewController?
    
    static func createModule() -> ListViewController {
        let view = ListViewController()
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension ListRouter: ListRouterProtocol {
    
    func navigate(_ route: ListRoutes) {
        switch route {
            
        case .detail(let movieId):
            guard let movieId = movieId else { return }
            
            let detailVC = MovieDetailRouter.createModule(movieID: movieId)
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
