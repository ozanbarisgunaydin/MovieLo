//
//  MovieListCell.swift
//  MovieLo
//
//  Created by Ozan Barış Günaydın on 3.09.2022.
//

import UIKit
import SDWebImage

protocol MovieListCellProtocol: AnyObject {
    func setMovieImage(_ imageUrl: URL)
    func setTitleLabel(_ text: String)
    func setMovieTypeLabel(_ text: String)
    func setYearLabel(_ text: String)
}

final class MovieListCell: UITableViewCell {
    
    @IBOutlet private weak var movieImage: UIImageView! {
        didSet {
            movieImage.layer.cornerRadius = 8
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var movieTypeLabel: UILabel!
    @IBOutlet private weak var showYearLabel: UILabel!
    
    
    var cellPresenter: MovieListCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension MovieListCell: MovieListCellProtocol {
    
    func setMovieImage(_ imageUrl: URL) {
        movieImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
    }
    
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
    
    func setMovieTypeLabel(_ text: String) {
        movieTypeLabel.text = text
    }
    
    func setYearLabel(_ text: String) {
        showYearLabel.text = text
    }
    
}
