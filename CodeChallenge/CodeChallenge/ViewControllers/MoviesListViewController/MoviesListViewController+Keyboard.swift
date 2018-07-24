//
//  MoviesListViewController+Keyboard.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/24/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import UIKit

extension MoviesListViewController {
    @objc func keyboardWillHide(notification: Notification) {
        self.moviesListTableView.contentInset = .zero
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let frame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.moviesListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        }
    }
}
