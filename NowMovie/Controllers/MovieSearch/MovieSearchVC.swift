//
//  MovieSearchController.swift
//  NowMovie
//
//  Created by trungnghia on 9/15/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class MovieSearchVC: UITableViewController {
    
    // MARK: - Properties
    private let searchController = UISearchController()
    private let viewModel = MovieSearchVM(service: MovieService())
    private let networkHandling = NetworkHandling()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        configureSearchController()
        setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkHandling.observerInternetConnection(controller: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        networkHandling.removeObserverInternetConnection()
    }
    
    deinit {
        viewModel.clearObservation()
        print("Clear observation for Movie Search screen")
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
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.searchTextField.returnKeyType = .done
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
        // Using debounce for sending key
        searchController.searchBar.searchTextField.reactive
            .controlEvents(.editingChanged)
            .debounce(0.5, on: QueueScheduler.main)
            .observeValues { [weak self] (textField) in
                if let text = textField.text, text.count > 0 {
                    self?.viewModel.searchMovies(searchKey: text)
                }
                
            }
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
            tableView.setEmptyMessage(message: "There is no movie.", size: 20)
        } else {
            tableView.restore()
        }
        
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reuseIdentifier, for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        
        let movie = viewModel.movieAtIndex(indexPath.row)
        cell.viewModel = MovieVM(movie: movie)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieSearchVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = viewModel.movieAtIndex(indexPath.row).id
        let controller = MovieDetailVC(id: id)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension MovieSearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKey = searchController.searchBar.text else { return }
        if searchKey.count == 0 {
            viewModel.movies.value.removeAll()
        }
    }
}

// MARK: UISearchControllerDelegate
extension MovieSearchVC: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
