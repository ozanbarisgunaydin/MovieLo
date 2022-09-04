//
//  SplashViewController.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
    func setRemoteConfig(text: String)
}

class SplashViewController: BaseViewController {

    @IBOutlet private weak var splashImage: UIImageView!
    @IBOutlet private weak var remoteConfigLabel: UILabel! {
        didSet {
            remoteConfigLabel.text = ""
        }
    }
    
    var presenter: SplashPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        showNoInternetAlert(title: "Connection Error", message: "No Internet Connection. Please check your connection and try again later.", closeActionTitle: "Okay")
    }
    
    func setRemoteConfig(text: String) {
        remoteConfigLabel.text = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.presenter.routeToList()
        }
    }

}
