//
//  NotificationNameExtension.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/23/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let FetchUpcomingMoviesDidFinish = Notification.Name(rawValue: "FetchUpcomingMoviesDidFinish")
    static let MovieImageFinishDownload = Notification.Name(rawValue: "MovieImageFinishDownload")
}
