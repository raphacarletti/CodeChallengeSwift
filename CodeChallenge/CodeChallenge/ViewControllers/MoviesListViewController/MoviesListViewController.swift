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
            self.moviesListTableView.separatorStyle = .none
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
        
        //Setup Navigation
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.tintColor = UIColor.darkBlueZodiac
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkBlueZodiac]
        self.navigationController?.navigationBar.isTranslucent = false
        
        // Setup the Search Controller
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Movie..."
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.searchBar.delegate = self
        self.moviesListTableView.backgroundColor = UIColor.TunaGray
        
        APIUpcomingMoviesService.getSharedInstance().getAllMovieGenres {
            APIUpcomingMoviesService.getSharedInstance().getUpcomingMovies(completion: { (movies) in
                self.handleGetUpcomingMovies(movies: movies)
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(movieImageFinishDownload(_:)), name: .MovieImageFinishDownload, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: .MovieImageFinishDownload, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleGetUpcomingMovies(movies: [Movie]?) {
        if let movies = movies {
            self.movies.append(contentsOf: movies)
        } else {
            let alert = UIAlertController(title: "Error", message: "Error fetching upcoming movies", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        self.moviesListTableView.tableFooterView = nil
    }
    
    func filterMovies() {
        if let searchTerm = self.searchTerm {
            self.filteredMovies = self.movies.filter({ (movie) -> Bool in
                return movie.title.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil).contains(searchTerm)
            })
        } else {
            self.filteredMovies = self.movies
        }
        self.moviesListTableView.reloadData()
    }
    
    @objc func movieImageFinishDownload(_ notification: Notification) {
        self.moviesListTableView.reloadData()
    }

}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let movie = self.filteredMovies[indexPath.row]
        let storyboard = UIStoryboard(name: .Movies)
        if let viewController = storyboard.instantiateViewController(vcName: .MovieDetail) as? MovieDetailViewController {
            viewController.movie = movie
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
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
        cell.setUpCellWith(movie: movie, isOdd: indexPath.row%2==0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count-1 && APIUpcomingMoviesService.getSharedInstance().canLoadMorePage() && self.searchTerm == nil {
            APIUpcomingMoviesService.getSharedInstance().getUpcomingMovies { (movies) in
                self.handleGetUpcomingMovies(movies: movies)
            }
            self.moviesListTableView.tableFooterView = LoadingMoreView(frame: CGRect(x: 0, y: 0, width: self.moviesListTableView.frame.width, height: 56))
        }
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
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
