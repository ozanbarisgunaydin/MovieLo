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
        remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("\n✅ Config fetched.. \n")
            remoteConfig.activate { changed, error in
                if error != nil {
                    print("\n🚨Error: \(error?.localizedDescription ?? "No error available.") \n")
                } else {
                    print("\n✅ Config activated.. \n")
                }
            }
          } else {
            print("\n🚨 Config not fetched..\n")
            print("\n🚨 Error: \(error?.localizedDescription ?? "No error available.")\n")
          }
          self.setNewValuesFromRemoteConfig()
        }
    }
    
    func setNewValuesFromRemoteConfig() {
        let newLabelText = remoteConfig.configValue(forKey: "splashText").stringValue ?? ""
        output?.setRemoteConfig(text: newLabelText)
    }

}
