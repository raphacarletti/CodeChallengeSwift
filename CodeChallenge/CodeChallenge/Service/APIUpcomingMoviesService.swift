//
//  APIService.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/23/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import Foundation
import Alamofire

class APIUpcomingMoviesService {
    // MARK: - Variables
    private static var sharedInstance: APIUpcomingMoviesService?
    var currentPage: Int = 0
    var totalPages: Int = 0
    var movies: [Movie] = []
    var genres: [Int: String] = [:]
    var isLoadingMoreMovies: Bool = false
    
    // MARK: - Initializations Methods
    private init() {}
    
    static func getSharedInstance() -> APIUpcomingMoviesService {
        guard let checkedSharedInstance = self.sharedInstance else {
            let newInstance = APIUpcomingMoviesService()
            self.sharedInstance = newInstance
            
            return newInstance
        }
        
        return checkedSharedInstance
    }
    
    func getUpcomingMovies() {
        self.currentPage += 1
        self.isLoadingMoreMovies = true
        let parameters: [String: Any] = [APIParameters.apiKey: APIConstants.key, APIParameters.page: self.currentPage]
        Alamofire.request("\(APIConstants.baseUrl)\(APIConstants.getUpcomingMovies)", method: .get, parameters: parameters).responseJSON { (response) in
            guard let valueDict = response.value as? [String: Any], let resultsArrays = valueDict[UpcomingMoviesAPIFields.results] as? [[String: Any]] else {
                return
            }

            for movie in resultsArrays {
                if let movie = Movie.parse(dict: movie) {
                    self.movies.append(movie)
                }
            }
            
            if let totalPages = valueDict[UpcomingMoviesAPIFields.totalPages] as? Int {
                self.totalPages = totalPages
            }
            
            self.isLoadingMoreMovies = false
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .FetchUpcomingMoviesDidFinish, object: nil)
            }
        }
    }
    
    func canLoadMorePage() -> Bool {
        return self.currentPage < self.totalPages && !self.isLoadingMoreMovies
    }
    
    func getAllMovieGenres(completion: @escaping ()->()) {
        let parameters: [String: Any] = [APIParameters.apiKey: APIConstants.key]
        Alamofire.request("\(APIConstants.baseUrl)\(APIConstants.getMovieGenres)", method: .get, parameters: parameters).responseJSON { (response) in
            guard let valueDict = response.value as? [String: Any], let genresArray = valueDict[MoviesGenresAPIFields.genres] as? [[String: Any]] else {
                return
            }
            
            for genre in genresArray {
                if let id = genre[MoviesGenresAPIFields.id] as? Int, let name = genre[MoviesGenresAPIFields.name] as? String {
                    self.genres[id] = name
                }
            }
            
            completion()
        }
    }
    
    func getMovieGenreName(genreId: Int) -> String? {
        guard let genre = self.genres[genreId] else {
            return nil
        }
        return genre
    }
}
