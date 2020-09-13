//
//  MovieDetailController.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {
    
    // MARK: - Properties
    let viewModel: MovieViewModel
    
    private let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .secondarySystemBackground
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "About the Movie"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    init(viewModel: MovieViewModel) {
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
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Movie image
        view.addSubview(movieImageView)
        movieImageView.setDimensions(width: view.frame.size.width, height: 250)
        movieImageView.centerX(inView: view)
        movieImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        if let url = URL(string: viewModel.detailImageUrl) {
            movieImageView.load(url: url)
        }
        
        // About the movie
        let stack = UIStackView(arrangedSubviews: [aboutLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        view.addSubview(stack)
        stack.anchor(top: movieImageView.bottomAnchor,
                     left: view.safeAreaLayoutGuide.leftAnchor,
                     right: view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 20,
                     paddingLeft: 12,
                     paddingRight: 12)
        descriptionLabel.text = viewModel.overview
    }
    
    // MARK: - Helpers
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = viewModel.title
    }
}
