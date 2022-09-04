//
//  SplashPresenter.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation
import FirebaseRemoteConfig

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
    
    private func setupRemoteConfigDefaults() {
        let defaultValue = ["RemoteConfigDefaults": "Hello world!" as NSObject]
        remoteConfig.setDefaults(defaultValue)
    }
}


extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnection(status: Bool) {
        if status {
            setupRemoteConfigDefaults()
            interactor.getRemoteConfing()
        } else {
            view.noInternetConnection()
        }
    }
    
    func setRemoteConfig(text: String) {
        view.setRemoteConfig(text: text)
    }
}
