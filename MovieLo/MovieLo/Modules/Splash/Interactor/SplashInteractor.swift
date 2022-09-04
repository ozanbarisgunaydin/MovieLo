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
        // TODO: There is a bug for lodoos text on the first run on simulator
        remoteConfig.fetchAndActivate(completionHandler: { [weak self] (status, error) in
            guard let self = self else { return }
            remoteConfig.fetch(withExpirationDuration: 5) { (status, error) in
                self.setNewValuesFromRemoteConfig()
            }
            
        })
    }
    
    func setNewValuesFromRemoteConfig() {
        let newLabelText = remoteConfig.configValue(forKey: "RemoteConfigDefaults").stringValue ?? ""
        output?.setRemoteConfig(text: newLabelText)
    }

}
