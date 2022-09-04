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
    
    lazy var workItem = WorkItem()

    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(view: SplashViewControllerProtocol, router: SplashRouterProtocol, interactor: SplashInteractorProtocol ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        setupRemoteConfigDefaults()
        interactor.checkInternetConnection()
    }
    
    func routeToList() {
        router.navigate(.listScreen)
    }
    
    private func setupRemoteConfigDefaults() {
        remoteConfig.setDefaults(fromPlist: "splashText")
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
}


extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnection(status: Bool) {
        if status {
            interactor.getRemoteConfing()
        } else {
            view.noInternetConnection()
        }
    }
    
    func setRemoteConfig(text: String) {
        if text == "" {
            workItem.perform(after: 0.5) { /// The bug of remote config at first run on a device for dublicate fetching managed with workItem. If there is a dublicate call workItem take the last one.
                self.interactor.getRemoteConfing()
            }
        } else {
            view.setRemoteConfig(text: text)
        }
    }
}
