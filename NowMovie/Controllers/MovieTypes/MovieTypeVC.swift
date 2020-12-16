//
//  MovieTypesController.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit
import Lottie

private let reuseIdentifier = "TypeCell"

protocol MovieTypesControllerDelegate: class {
    func didSelectMovieType(_ type: MovieType)
    func didSelectExit()
}

class MovieTypeVC: UITableViewController {
    
    // MARK: - Properties
    private let waitingAnimationView = AnimationView(animation: Animation.named("waiting"))
    weak var delegate: MovieTypesControllerDelegate?
    private var viewModel: MovieTypeVM?
    private let movieType: MovieType
    
    init(movieType: MovieType) {
        self.movieType = movieType
        viewModel = MovieTypeVM(movieType: movieType)
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupTableViewFooter()
    }
    
    // MARK: - Helpers
    private func setupNavigationBar() {
        navigationItem.title = "Movie Type Selection"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(handleDismissal))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(handleExit))
    }
    
    private func setupTableView() {
        tableView.accessibilityLabel = "Movie Types table"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setupTableViewFooter() {
        waitingAnimationView.animationSpeed = 1
        waitingAnimationView.loopMode = .loop
        waitingAnimationView.contentMode = .scaleAspectFit
        waitingAnimationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width)
        waitingAnimationView.play()
    }
    
    // MARK: - Selectors
    @objc private func handleDismissal() {
        dismiss(animated: true)
    }
    
    @objc private func handleExit() {
        dismiss(animated: true) {
            self.delegate?.didSelectExit()
        }
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "movie type"
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return waitingAnimationView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return view.frame.size.width / 1.5
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
