//
//  MovieDetailViewController.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/24/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView! {
        didSet {
            self.posterImage.clipsToBounds = true
            self.posterImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        if let movie = self.movie {
            self.movieNameLabel.text = movie.title
            self.posterImage.image = movie.image
            self.releaseDateLabel.text = movie.releaseDate
            self.overviewTextView.text = movie.overview
            self.genreLabel.text = movie.genre
        }
    }
}
