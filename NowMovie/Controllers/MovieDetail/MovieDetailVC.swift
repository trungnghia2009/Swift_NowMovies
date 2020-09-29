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
    let viewModel: MovieDetailVM
    
    private lazy var headerView = MovieDetailHeader(viewModel: viewModel)
    
    // MARK: - Lifecycle
    init(viewModel: MovieDetailVM) {
        self.viewModel = viewModel
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
    }
    
    // MARK: - Helpers
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Movie Details"
    }
    
    private func setupTableView() {
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 320)
        tableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
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
}

// MARK: MovieDetailHeaderDelegate
extension MovieDetailVC: MovieDetailHeaderDelegate {
    func didTapPlayTrailerButton() {
        print("Did Tap Play Trailer button...")
    }
    
    
}
