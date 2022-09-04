//
//  SplashInteractor.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import Foundation
import FirebaseRemoteConfig

protocol SplashInteractorProtocol: AnyObject {
    func checkInternetConnection()
    func getRemoteConfing()
}

protocol SplashInteractorOutputProtocol: AnyObject {
    func internetConnection(status: Bool)
    func setRemoteConfig(text: String)
}


final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol {
    
    func checkInternetConnection() {
        let internetStatus = NetworkManager.shared.isConnectedToInternet()
        self.output?.internetConnection(status: internetStatus)
    }
    
    func getRemoteConfing() {
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
            guard error == nil else { return }
            remoteConfig.activate()
            self.setNewValuesFromRemoteConfig()
        }
    }
    
    func setNewValuesFromRemoteConfig() {
        let newLabelText = remoteConfig.configValue(forKey: "RemoteConfigDefaults").stringValue ?? ""
        output?.setRemoteConfig(text: newLabelText)
    }

}
