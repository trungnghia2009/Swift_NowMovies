//
//  MovieSearchController.swift
//  NowMovie
//
//  Created by trungnghia on 9/15/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class MovieSearchVC: UITableViewController {

    // MARK: - Properties
    private let searchController = UISearchController()
    var viewModel = MovieSearchVM(service: MovieService())
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        configureSearchController()
        setupObserver()
    }
    
    deinit {
        viewModel.clearObservation()
        print("Clear Observation")
    }
    
    // MARK: - Helpers
    private func setupObserver() {
        viewModel.movies.producer.startWithResult { [weak self] (_) in
            self?.tableView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Movie Search"
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    private func setupTableView() {
        tableView.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Selectors
    
}

// MARK: - UITableViewDataSource
extension MovieSearchVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numberOfRowsInSection(section) == 0 {
            tableView.setEmptyMessage(message: "There is no movies", size: 20)
        } else {
            tableView.restore()
        }
        
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reuseIdentifier, for: indexPath) as! MovieListCell
        cell.accessoryType = .disclosureIndicator
        
        let movie = viewModel.movieAtIndex(indexPath.row)
        cell.viewModel = MovieDetailVM(movie: movie)
        return cell
    }
}


// MARK: - UITableViewDelegate
extension MovieSearchVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movieAtIndex(indexPath.row)
        let controller = MovieDetailVC(viewModel: MovieDetailVM(movie: movie))
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension MovieSearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKey = searchController.searchBar.text else { return }
        if searchKey.count == 0 {
            viewModel.movies.value.removeAll()
            return
        }
        
        viewModel.searchMovies(searchKey: searchKey)
    }
    
    
}
