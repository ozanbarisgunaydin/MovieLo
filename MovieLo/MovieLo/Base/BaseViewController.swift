//
//  BaseViewController.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import UIKit

class BaseViewController: UIViewController {

    lazy var workItem = WorkItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        /* no-op */
    }
    
    func showNoInternetAlert(title:String, message:String, closeActionTitle: String? = "Close App") {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: closeActionTitle,
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    exit(0)
                }
        }))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }

}
