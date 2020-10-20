//
//  MovieDetailController.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class MovieDetailVC: UITableViewController {
    
    // MARK: - Properties
    private let viewModel = MovieDetailVM(service: MovieService())
    
    private let id: Int
    
    // MARK: - Lifecycle
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTableView()
        setupObserver()
        viewModel.fetchMovieDetail(id: id)
    }
    
    deinit {
        viewModel.clearObservation()
        print("Clear observation for Movie List screen")
    }
    
    // MARK: - Helpers
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Movie Details"
    }
    
    private func setupTableView() {
        tableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func setupObserver() {
        viewModel.movieDetail.producer.startWithResult { [weak self] (_) in
            self?.tableView.reloadData()
            print("Got API...")
        }
    }
    
}

// MARK: UITableViewDataSource
extension MovieDetailVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.reuseIdentifier, for: indexPath) as! MovieDetailCell
        cell.viewModel = viewModel
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MovieDetailHeader(viewModel: viewModel)
        headerView.delegate = self
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 320
    }
    
}

// MARK: MovieDetailHeaderDelegate
extension MovieDetailVC: MovieDetailHeaderDelegate {
    func didTapPlayTrailerButton() {
        print("Did Tap Play Trailer button...")
    }
    
    
}
