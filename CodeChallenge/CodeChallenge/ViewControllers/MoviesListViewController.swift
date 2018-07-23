//
//  MoviesListViewController.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/23/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    @IBOutlet weak var moviesListTableView: UITableView! {
        didSet {
            self.moviesListTableView.delegate = self
            self.moviesListTableView.dataSource = self
            self.moviesListTableView.rowHeight = UITableViewAutomaticDimension
            self.moviesListTableView.estimatedRowHeight = 52
            self.moviesListTableView.register(MoviesListTableViewCell.self, forCellReuseIdentifier: String(describing: MoviesListTableViewCell.self))
            self.moviesListTableView.register(UINib(nibName: String(describing: MoviesListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MoviesListTableViewCell.self))
        }
    }
    
    var movies: [Movie] = [] {
        didSet {
            self.filterMovies()
        }
    }
    var filteredMovies: [Movie] = []
    var searchTerm: String? = nil {
        didSet {
            self.filterMovies()
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Movie..."
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        APIUpcomingMoviesService.getSharedInstance().getAllMovieGenres {
            APIUpcomingMoviesService.getSharedInstance().getUpcomingMovies()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getUpcomingMovies), name: .FetchUpcomingMoviesDidFinish, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getUpcomingMovies), name: .MovieImageFinishDownload, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterMovies() {
        if let searchTerm = self.searchTerm {
            self.filteredMovies = self.movies.filter({ (movie) -> Bool in
                return movie.title.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)nt.contains(searchTerm)
            })
        } else {
            self.filteredMovies = self.movies
        }
        self.moviesListTableView.reloadData()
    }
    
    @objc func getUpcomingMovies() {
        self.movies = APIUpcomingMoviesService.getSharedInstance().movies
        self.moviesListTableView.tableFooterView = nil
        self.moviesListTableView.reloadData()
    }
    
    @objc func movieImageFinishDownload(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any], let movieId = userInfo[NotificationUserInforKey.movieId] as? Int else {
            return
        }
        
        self.movies = APIUpcomingMoviesService.getSharedInstance().movies
        if let index = self.movies.index(where: { (movie) -> Bool in
            return movie.id == movieId
        }) {
            self.moviesListTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }

}

extension MoviesListViewController: UITableViewDelegate {
    
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MoviesListTableViewCell.self), for: indexPath) as? MoviesListTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = self.filteredMovies[indexPath.row]
        cell.setUpCellWith(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count-1 && APIUpcomingMoviesService.getSharedInstance().canLoadMorePage() && self.searchTerm == nil {
            APIUpcomingMoviesService.getSharedInstance().getUpcomingMovies()
            self.moviesListTableView.tableFooterView = LoadingMoreView(frame: CGRect(x: 0, y: 0, width: self.moviesListTableView.frame.width, height: 56))
        }
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchTerm = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {
            return
        }
        let searchTermDiacriticInsensitive = searchTerm.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
        self.searchTerm = searchTermDiacriticInsensitive
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = nil
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTerm = searchBar.text else {
            self.searchTerm = nil
            return
        }
        let searchTermDiacriticInsensitive = searchTerm.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
        self.searchTerm = searchTermDiacriticInsensitive
    }
}
