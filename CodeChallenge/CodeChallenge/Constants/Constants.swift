//
//  Constants.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/23/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import Foundation

struct APIConstants {
    static let key: String = "1f54bd990f1cdfb230adb312546d765d"
    static let baseUrl: String = "https://api.themoviedb.org/3/"
    static let baseImageUrl: String = "https://image.tmdb.org/t/p/"
    static let getUpcomingMovies: String = "movie/upcoming"
    static let getMovieGenres: String = "genre/movie/list"
    static let posterMinimumWidth: String = "w92"
    static let backdropMinimumWidth: String = "w300"
}

struct APIParameters {
    static let apiKey: String = "api_key"
    static let page: String = "page"
}

struct UpcomingMoviesAPIFields {
    static let results: String = "results"
    static let id: String = "id"
    static let backdropPath: String = "backdrop_path"
    static let posterPath: String = "poster_path"
    static let releaseDate: String = "release_date"
    static let overview: String = "overview"
    static let title: String = "title"
    static let genresId = "genre_ids"
    static let page: String = "page"
    static let totalPages: String = "total_pages"
}

struct MoviesGenresAPIFields {
    static let genres: String = "genres"
    static let id: String = "id"
    static let name: String = "name"
}

struct NotificationUserInforKey {
    static let movieId: String = "movieId"
}

enum StoryboardName: String {
    case Movies = "Movies"
}

enum ViewControllerName: String {
    case MovieDetail = "MovieDetailViewController"
}
