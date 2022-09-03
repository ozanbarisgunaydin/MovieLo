//
//  MovieDetailViewController.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 4.09.2022.
//

import UIKit
import SDWebImage

protocol MovieDetailViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setMoviePoster(_ imageUrl: URL)
    func setMovieTitle(_ text: String)
    func setMovieDescription(_ text: String)
    func setVoteScore(_ text: String)
    func setReleaseDate(_ text: String)
    func setImdbAvaibleView()
}

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet private weak var moviePosterImage: UIImageView! {
        didSet {
            moviePosterImage.layer.cornerRadius = 8
        }
    }
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var voteScoreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var imdbAvaibleView: UIView! {
        didSet {
            imdbAvaibleView.layer.cornerRadius = 8
            imdbAvaibleView.layer.borderColor = UIColor.lightGray.cgColor
            imdbAvaibleView.layer.borderWidth = 1
            imdbAvaibleView.isHidden = true
        }
    }
    
    var presenter: MovieDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func didTapImdb(_ sender: Any) {
        presenter.goToImdbPage()
    }
    
}

// MARK: - MovieDetailViewControllerProtocol
extension MovieDetailViewController: MovieDetailViewControllerProtocol, LoadingShowable {
    
    func setMoviePoster(_ imageUrl: URL) {
        moviePosterImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_movie_poster"))
    }
    
    func setMovieTitle(_ text: String) {
        self.title = text
    }
    
    func setMovieDescription(_ text: String) {
        movieDescriptionLabel.text = text
    }
    
    func setVoteScore(_ text: String) {
        voteScoreLabel.text = text
    }
    
    func setReleaseDate(_ text: String) {
        releaseDateLabel.text = text
    }
    
    func setImdbAvaibleView() {
        imdbAvaibleView.isHidden = false
    }
    
    func reloadData() {
        self.presenter.loadInputViews()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
}
