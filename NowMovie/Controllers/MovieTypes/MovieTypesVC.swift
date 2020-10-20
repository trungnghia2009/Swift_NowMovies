//
//  MovieTypesController.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TypeCell"

enum MovieType: CaseIterable, CustomStringConvertible {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing Movies"
        case .popular: return "Popular Movies"
        case .topRated: return "Top Rated Movies"
        case .upcoming: return "Upcoming Movies"
        }
    }
}

protocol MovieTypesControllerDelegate: class {
    func didSelectMovieType(_ type: MovieType)
}

class MovieTypesVC: UITableViewController {
    
    // MARK: - Properties
    weak var delegate: MovieTypesControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: - Helpers
    private func setupNavigationBar() {
        navigationItem.title = "Movie Type Selection"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(handleDismissal))
    }
    
    private func setupTableView() {
        tableView.accessibilityLabel = "Movie Types table"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Selectors
    @objc private func handleDismissal() {
        dismiss(animated: true)
    }
}


// MARK: - UITableViewDataSource
extension MovieTypesVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let cellName = MovieType.allCases[indexPath.row].description
        cell.textLabel?.text = cellName
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieTypesVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = MovieType.allCases[indexPath.row]
        dismiss(animated: true) {
            self.delegate?.didSelectMovieType(type)
        }
        
    }
}
