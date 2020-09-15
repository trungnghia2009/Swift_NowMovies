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
    let viewModel: MovieDetailVM
    
    private var scrollView: UIScrollView!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .secondarySystemBackground
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var playTrailerView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 70, height: 70)
        iv.layer.cornerRadius = 35
        iv.layer.borderColor = UIColor.systemBackground.cgColor
        iv.layer.borderWidth = 3
        iv.backgroundColor = .systemBackground
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "play.circle.fill")
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlayButton))
        iv.addGestureRecognizer(tapGesture)
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
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        
        let containerView = UIView(frame: scrollView.bounds)
        scrollView.addSubview(containerView)
        
        // Movie title
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: containerView.safeAreaLayoutGuide.topAnchor,
                          left: containerView.safeAreaLayoutGuide.leftAnchor,
                          right: containerView.safeAreaLayoutGuide.rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 12,
                          paddingRight: 12)
        titleLabel.text = viewModel.title

        // Movie image
        containerView.addSubview(movieImageView)
        movieImageView.setDimensions(width: scrollView.frame.size.width, height: 250)
        movieImageView.centerX(inView: scrollView)
        movieImageView.anchor(top: titleLabel.bottomAnchor, paddingTop: 20)
        if let url = URL(string: viewModel.detailImageUrl) {
            movieImageView.load(url: url)
        }
        
        // Play trailer button
        containerView.addSubview(playTrailerView)
        playTrailerView.anchor(top: movieImageView.bottomAnchor,
                                 right: containerView.safeAreaLayoutGuide.rightAnchor,
                                 paddingTop: -35,
                                 paddingRight: 35)

        // About the movie
        let stack = UIStackView(arrangedSubviews: [aboutLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        containerView.addSubview(stack)
        stack.anchor(top: movieImageView.bottomAnchor,
                     left: scrollView.safeAreaLayoutGuide.leftAnchor,
                     right: scrollView.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 20,
                     paddingLeft: 12,
                     paddingRight: 12)
        
        descriptionLabel.text = viewModel.overview
        
        
        
        scrollView.contentSize = CGSize(width: view.frame.size.width,
                                        height: containerView.frame.size.height + 1)
    }
    
    // MARK: - Helpers
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Movie Details"
    }
    
    // MARK: Selectors
    @objc private func didTapPlayButton() {
        print("Do something...")
    }
}
