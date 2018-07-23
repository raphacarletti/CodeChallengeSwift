//
//  Movie.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/23/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    var genre: String?
    var posterPath: String?
    var backdropPath: String?
    var image: UIImage?
    
    init(id: Int, title: String, overview: String, releaseDate: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    static func parse(dict: [String: Any]) -> Movie? {
        guard let id = dict[UpcomingMoviesAPIFields.id] as? Int, let title = dict[UpcomingMoviesAPIFields.title] as? String, let overview = dict[UpcomingMoviesAPIFields.overview] as? String, let releaseDate = dict[UpcomingMoviesAPIFields.releaseDate] as? String else {
            print("Cannot create Movie model")
            return nil
        }
        let movie = Movie(id: id, title: title, overview: overview, releaseDate: releaseDate)
        
        if let genreIds = dict[UpcomingMoviesAPIFields.genresId] as? [Int], let genreId = genreIds.first, let genre = APIUpcomingMoviesService.getSharedInstance().getMovieGenreName(genreId: genreId) {
            movie.genre = genre
        }
        
        if let posterPath = dict[UpcomingMoviesAPIFields.posterPath] as? String {
            movie.posterPath = posterPath
        }
        
        if let backdropPath = dict[UpcomingMoviesAPIFields.backdropPath] as? String {
            movie.backdropPath = backdropPath
        }
        
        APIMovieImagesService.getSharedInstance().getMovieImage(movie: movie)
        
        return movie
    }
}
