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
    @IBOutlet weak var overviewInfoLabel: UILabel!
    @IBOutlet weak var genreInfoLabel: UILabel!
    
    //Image constraints
    @IBOutlet weak var heightPortraitImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthLandscapeImageConstraintRxC: NSLayoutConstraint!
    @IBOutlet weak var widthtLandscapeImageConstraintCxC: NSLayoutConstraint!
    
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
            self.releaseDateLabel.text = movie.releaseDate
            
            if let image = movie.image {
                self.posterImage.image = image
            } else {
                self.heightPortraitImageConstraint.constant = 0
                self.widthLandscapeImageConstraintRxC.constant = 0
                self.widthtLandscapeImageConstraintCxC.constant = 0
                self.posterImage.isHidden = true
            }
        
            if movie.overview != "" {
                self.overviewTextView.text = movie.overview
            } else {
                self.overviewTextView.isHidden = true
                self.overviewInfoLabel.isHidden = true
            }
            
            if movie.genre != nil {
                self.genreLabel.text = movie.genre
            } else {
                self.genreLabel.isHidden = true
                self.genreInfoLabel.isHidden = true
            }
        }
    }
}
