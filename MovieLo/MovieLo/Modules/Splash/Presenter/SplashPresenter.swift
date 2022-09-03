//
//  SplashPresenter.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func viewDidLoad()
    func routeToList()
}

final class SplashPresenter: SplashPresenterProtocol {
    
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(view: SplashViewControllerProtocol, router: SplashRouterProtocol, interactor: SplashInteractorProtocol ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.checkInternetConnection()
    }
    
    func routeToList() {
        router.navigate(.listScreen)
    }
    
}


extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnection(status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.routeToList()
            }
        } else {
            view.noInternetConnection()
        }
    }
}
