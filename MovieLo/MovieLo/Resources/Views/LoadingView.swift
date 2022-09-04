//
//  LoadingView.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import UIKit

class LoadingView {
    var spinnerActivityView: Spinner = Spinner()
    static let shared = LoadingView()
    
    var blurView: UIVisualEffectView = UIVisualEffectView()
    var width: CGFloat = 96
    var height: CGFloat = 96
    var loadingText: String = "Loading..."
    
    private init() {
        configure()
    }

    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        spinnerActivityView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        spinnerActivityView.center = blurView.center
        spinnerActivityView.theme = .dark
        spinnerActivityView.labelText = self.loadingText
        spinnerActivityView.enableInnerLayer = true
        spinnerActivityView.hidesWhenStopped = true
        blurView.contentView.addSubview(spinnerActivityView)
    }

    func startLoading() {
        UIApplication.shared.currentUIWindow()?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        spinnerActivityView.startAnimating()
    }

    func hideLoading() {
        blurView.removeFromSuperview()
        spinnerActivityView.stopAnimating()
    }
}
