//
//  SplashViewController.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

class SplashViewController: BaseViewController {

    @IBOutlet private weak var splashImage: UIImageView!

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
}
