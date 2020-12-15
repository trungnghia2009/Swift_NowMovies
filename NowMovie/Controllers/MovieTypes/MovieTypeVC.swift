//
//  MovieTypesController.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TypeCell"

protocol MovieTypesControllerDelegate: class {
    func didSelectMovieType(_ type: MovieType)
}

class MovieTypeVC: UITableViewController {
    
    // MARK: - Properties
    weak var delegate: MovieTypesControllerDelegate?
    private var viewModel: MovieTypeVM?
    private let movieType: MovieType
    
    init(movieType: MovieType) {
        self.movieType = movieType
        viewModel = MovieTypeVM(movieType: movieType)
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
extension MovieTypeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        guard let typeName = viewModel?.movieTypeAtIndex(indexPath.row) else { return cell }
        if viewModel?.getValue() == typeName {
            cell.accessoryType = .checkmark
        }
        cell.textLabel?.text = typeName
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieTypeVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = MovieType.allCases[indexPath.row]
        dismiss(animated: true) {
            self.delegate?.didSelectMovieType(type)
        }
        
    }
}
