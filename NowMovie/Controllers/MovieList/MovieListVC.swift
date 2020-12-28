//
//  MovieListController.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol MovieListVCDelegate: class {
    func didTapMenuButton()
}

class MovieListVC: UITableViewController {
    
    // MARK: - Properties
    weak var delegate: MovieListVCDelegate?
    private var movieType = MovieType.nowPlaying
    private let viewModel = MovieListVM(service: MovieService())
    private let networkHandling = NetworkHandling()
    private var isScrollToTop = false
    
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
        setupPullToRefresh()
        viewModel.fetchMovies(type: movieType)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        networkHandling.observerInternetConnection(controller: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        networkHandling.removeObserverInternetConnection()
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
        viewModel.clearObservation()
        print("Clear observation for Movie List screen")
    }
    
    
    // MARK: - Helpers
    private func setupObserver() {
        viewModel.movies.producer.startWithResult { [weak self] _ in
            guard let self = self else { return }
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.tableFooterView = nil
            self.tableView.reloadData()
            if self.isScrollToTop {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = movieType.description
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "film_icon"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRightBarButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapLeftBarButton))
    }
    
    private func setupTableView() {
        tableView.accessibilityLabel = "List Movie table"
        tableView.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        footerView.addSubview(spinner)
        spinner.center = footerView.center
        spinner.startAnimating()
        return footerView
    }
    
    // MARK: - Selectors
    @objc private func didTapRightBarButton() {
        let controller = MovieTypeVC(movieType: movieType)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true)
    }
    
    @objc private func didTapLeftBarButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc private func didTapSearchButton() {
        let controller = MovieSearchVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func refresh() {
        viewModel.fetchMovies(type: movieType)
    }
    
}


// MARK: - UITableViewDataSource
extension MovieListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

// MARK: Handle context menu
extension MovieListVC {
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let identifier = "\(index)" as NSString
        // let selectedMovie = viewModel.movieAtIndex(index)
        
        let contextMenu = UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { (_) -> UIMenu? in
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { (_) in
                
            }
            
            let likeAction = UIAction(title: "Give me a like", image: UIImage(systemName: "hand.thumbsup")) { (_) in
                
            }
            
            return UIMenu.init(title: "", children: [shareAction, likeAction])
        }
        return contextMenu
    }
    
    // Perform preview action
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard
            let identifier = configuration.identifier as? String,
            let index = Int(identifier)
        else { return }
        
        let selectedMovieId = viewModel.movieAtIndex(index).id
        let controller = MovieDetailVC(id: selectedMovieId)
        navigationController?.pushViewController(controller, animated: true)
    }

}

// MARK: - UITableViewDelegate
extension MovieListVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = viewModel.movieAtIndex(indexPath.row).id
        let controller = MovieDetailVC(id: id)
        navigationController?.pushViewController(controller, animated: true)
    }
}


// MARK: UIScrollViewDelegate
extension MovieListVC {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 10 - scrollView.frame.size.height) {
            guard !viewModel.isPaginating else {
                // We are already fetching more data
                return
            }
            print("Fetch more movies")
            tableView.tableFooterView = createSpinnerFooter()
            isScrollToTop = false
            viewModel.setIsPaginating(value: true)
            navigationItem.rightBarButtonItem?.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.viewModel.fetchMoreMovies(type: self.movieType)
            }
        }
    }
}

// MARK: - MovieTypesControllerDelegate
extension MovieListVC: MovieTypesControllerDelegate {
    func didSelectExit() {
        PresenterManager.shared.show(vc: .firstScreenController)
    }
    
    func didSelectMovieType(_ type: MovieType) {
        navigationItem.title = type.description
        movieType = type
        isScrollToTop = true
        viewModel.setIsPaginating(value: true)
        viewModel.fetchMovies(type: type)
    }
    
    
    
    
}
