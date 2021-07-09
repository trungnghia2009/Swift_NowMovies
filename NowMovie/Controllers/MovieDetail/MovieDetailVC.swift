//
//  MovieDetailController.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailVC: UITableViewController {
    
    // MARK: - Properties
    private let viewModel = MovieDetailVM(service: MovieService())
    
    private let id: Int
    
    // MARK: - Lifecycle
    init(id: Int) {
        self.id = id
        super.init(style: .grouped)  // .group to scroll cell + header
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
        MovieLog.info(message: "Clear observation for Movie List screen")
    }
    
    // MARK: - Helpers
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Movie Details"
    }
    
    private func setupTableView() {
        tableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.reuseIdentifier)
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func setupObserver() {
        viewModel.movieDetail.producer.startWithResult { [weak self] (_) in
            self?.tableView.reloadData()
            MovieLog.info(message: "Got API...")
        }
    }
}

// MARK: UITableViewDataSource
extension MovieDetailVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.reuseIdentifier, for: indexPath) as? MovieDetailCell else {
            return UITableViewCell()
        }
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
        switch UIScreen.main.traitCollection.userInterfaceIdiom {
        case .pad:
            // Handle for iPad
            return 280 + 200
        default:
            return 280
        }
    }
}

// MARK: MovieDetailHeaderDelegate
extension MovieDetailVC: MovieDetailHeaderDelegate {
    func didTapAlbumButton() {
        MovieLog.info(message: "Did tap Album button...")
    }
    
    func didTapShareButton() {
        MovieLog.info(message: "Did tap Share button...")
        let title = viewModel.title
        guard let website = URL(string: viewModel.homepage) else { return }
        let items: [Any] = [title, website]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true, completion: nil)
    }
    
    func didTapFavoriteButton() {
        MovieLog.info(message: "Did tap Favorite button...")
    }
    
    func didTapPlayTrailerButton() {
        MovieLog.info(message: "Did tap Play Trailer button...")
    }
}
