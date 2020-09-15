//
//  MovieListController.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit
import ReactiveSwift

class MovieListVC: UITableViewController {
    
    // MARK: - Properties
    let movieTypeDefault = MovieType.allCases[0]
    var viewModel = MovieListVM(service: MovieService())
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .systemOrange
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.setDimensions(width: 50, height: 50)
        button.layer.cornerRadius = 25
        button.addShadow()
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupObserver()
        viewModel.fetchMovies(type: movieTypeDefault)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(searchButton)
        searchButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.safeAreaLayoutGuide.rightAnchor,
                            paddingBottom: 30,
                            paddingRight: 20)
    }
    
    deinit {
        print("Clear observation")
        viewModel.clearObservation()
    }
    
    
    // MARK: - Helpers
    private func setupObserver() {
        viewModel.movies.producer.startWithResult { [weak self] (_) in
            self?.tableView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = movieTypeDefault.description
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "flame"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRightBarButton))
    }
    
    private func setupTableView() {
        tableView.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Selectors
    @objc private func didTapRightBarButton() {
        let controller = MovieTypesController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true)
    }
    
    @objc private func didTapSearchButton() {
        let controller = MovieSearchVC()
        navigationController?.pushViewController(controller, animated: true)
    }

}


// MARK: - UITableViewDataSource
extension MovieListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
extension MovieListVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movieAtIndex(indexPath.row)
        let controller = MovieDetailVC(viewModel: MovieDetailVM(movie: movie))
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - MovieTypesControllerDelegate
extension MovieListVC: MovieTypesControllerDelegate {
    func didSelectMovieType(_ type: MovieType) {
        navigationItem.title = type.description
        viewModel.fetchMovies(type: type)
    }
    
    
    
    
}
