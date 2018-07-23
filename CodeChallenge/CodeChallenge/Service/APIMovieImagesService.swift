//
//  APIMovieImagesService.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/23/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import Foundation
import UIKit

enum ImageType {
    case Poster
    case Backdrop
}

class APIMovieImagesService {
    // MARK: - Variables
    private static var sharedInstance: APIMovieImagesService?
    
    // MARK: - Initializations Methods
    private init() {}
    
    static func getSharedInstance() -> APIMovieImagesService {
        guard let checkedSharedInstance = self.sharedInstance else {
            let newInstance = APIMovieImagesService()
            self.sharedInstance = newInstance
            
            return newInstance
        }
        
        return checkedSharedInstance
    }
    
    func getMovieImage(movie: Movie) {
        if movie.image == nil {
            let path: String?
            let type: ImageType
            if let posterPath = movie.posterPath {
                path = posterPath
                type = .Poster
            } else if let backdropPath = movie.backdropPath {
                path = backdropPath
                type = .Backdrop
            } else {
                return
            }
            if let path = path {
                DispatchQueue.global().async {
                    let url: URL?
                    switch type {
                    case .Poster:
                        url = URL(string: "\(APIConstants.baseImageUrl)\(APIConstants.posterMinimumWidth)\(path)")
                    case .Backdrop:
                        url = URL(string: "\(APIConstants.baseImageUrl)\(APIConstants.backdropMinimumWidth)\(path)")
                    }
                    if let url = url {
                        guard let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) else {
                            return
                        }
                        movie.image = image
                        
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .MovieImageFinishDownload, object: nil, userInfo: [NotificationUserInforKey.movieId: movie.id])
                        }
                    }
                }
            }
        }
    }
}
