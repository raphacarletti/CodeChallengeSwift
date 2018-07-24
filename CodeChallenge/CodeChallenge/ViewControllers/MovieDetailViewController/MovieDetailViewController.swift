//
//  MovieDetailViewController.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/24/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieNameLabel: UILabel! {
        didSet {
            self.movieNameLabel.font = UIFont.boldSystemFont(ofSize: 19)
            self.movieNameLabel.textColor = UIColor.white
        }
    }
    @IBOutlet weak var posterImage: UIImageView! {
        didSet {
            self.posterImage.clipsToBounds = true
            self.posterImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var releadeDateInfo: UILabel! {
        didSet {
            self.releadeDateInfo.textColor = UIColor.semiTranslucentWhite
        }
    }
    @IBOutlet weak var releaseDateLabel: UILabel! {
        didSet {
            self.releaseDateLabel.textColor = UIColor.white
        }
    }
    @IBOutlet weak var genreLabel: UILabel! {
        didSet {
            self.genreLabel.textColor = UIColor.white
        }
    }
    @IBOutlet weak var overviewTextView: UITextView! {
        didSet {
            self.overviewTextView.backgroundColor = UIColor.darkBlueZodiac
            self.overviewTextView.textColor = UIColor.white
            self.overviewTextView.isEditable = false
        }
    }
    @IBOutlet weak var overviewInfoLabel: UILabel! {
        didSet {
            self.overviewInfoLabel.textColor = UIColor.semiTranslucentWhite
        }
    }
    @IBOutlet weak var genreInfoLabel: UILabel! {
        didSet {
            self.genreInfoLabel.textColor = UIColor.semiTranslucentWhite
        }
    }
    
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
            self.view.backgroundColor = UIColor.darkBlueZodiac
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
