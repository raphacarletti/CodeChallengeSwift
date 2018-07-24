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
    @IBOutlet weak var movieNameLabel: UILabel! {
        didSet {
            self.movieNameLabel.textColor = UIColor.white
            self.movieNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }
    @IBOutlet weak var genreLabel: UILabel! {
        didSet {
            self.genreLabel.textColor = UIColor.white
        }
    }
    @IBOutlet weak var releaseDateLabel: UILabel! {
        didSet {
            self.releaseDateLabel.textColor = UIColor.semiTranslucentWhite
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.blueZodiac
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCellWith(movie: Movie, isOdd: Bool) {
        if isOdd {
            self.backgroundColor = UIColor.blueZodiac
        } else {
            self.backgroundColor = UIColor.darkBlueZodiac
        }
        self.movieNameLabel.text = movie.title
        self.releaseDateLabel.text = movie.releaseDate
        self.genreLabel.text = movie.genre ?? ""
        if let image = movie.image {
            self.posterImage.image = image
        } else {
            self.posterImage.image = UIImage.movieImage
        }
        self.posterImage.layer.cornerRadius = self.posterImage.frame.height/2
    }
    
}
