//
//  MoviesListTableViewCell.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/23/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView! {
        didSet {
            self.posterImage.contentMode = .scaleAspectFill
            self.posterImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel! {
        didSet {
            self.genreLabel.textColor = UIColor.lightGrayMovieList
        }
    }
    @IBOutlet weak var releaseDateLabel: UILabel! {
        didSet {
            self.releaseDateLabel.textColor = UIColor.lightGrayMovieList
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCellWith(movie: Movie) {
        self.movieNameLabel.text = movie.title
        self.releaseDateLabel.text = movie.releaseDate
        self.genreLabel.text = movie.genre ?? ""
        if let image = movie.image {
            self.posterImage.image = image
        } else {
            self.posterImage.image = UIImage.movieImage
        }
    }
    
}
