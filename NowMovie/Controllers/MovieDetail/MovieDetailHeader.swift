//
//  MovieDetailHeader.swift
//  NowMovie
//
//  Created by NghiaTran on 9/29/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

protocol MovieDetailHeaderDelegate: class {
    func didTapPlayTrailerButton()
}

class MovieDetailHeader: UIView {

    // MARK: Properties
    weak var delegate: MovieDetailHeaderDelegate?
    private let viewModel: MovieDetailVM
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemBackground
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .label
        label.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        label.layer.cornerRadius = 10
        label.setDimensions(width: 90, height: 30)
        return label
    }()
    
    lazy var playTrailerView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 70, height: 70)
        iv.layer.cornerRadius = 35
        iv.layer.borderColor = UIColor.systemBackground.cgColor
        iv.layer.borderWidth = 2
        iv.backgroundColor = .systemBackground
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "play.circle.fill")
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlayButton))
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    
    // MARK: Lifecycle
    init(viewModel: MovieDetailVM) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .systemBackground

        // Movie image
        addSubview(movieImageView)
        movieImageView.setDimensions(width: UIScreen.main.bounds.width, height: 250)
        movieImageView.centerX(inView: self)
        movieImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        if let url = URL(string: viewModel.detailImageUrl) {
            movieImageView.load(url: url)
        }
        
        // Movie rating
        addSubview(ratingLabel)
        ratingLabel.anchor(left: self.safeAreaLayoutGuide.leftAnchor,
                           bottom: movieImageView.bottomAnchor,
                           paddingLeft: 12,
                           paddingBottom: 20)
        ratingLabel.text = viewModel.rating
        
        // Movie title
        addSubview(titleLabel)
        titleLabel.anchor(top: movieImageView.bottomAnchor,
                          left: self.safeAreaLayoutGuide.leftAnchor,
                          right: self.safeAreaLayoutGuide.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 12,
                          paddingRight: 60)
        titleLabel.text = viewModel.titleAndYear
        
        // Play trailer button
        addSubview(playTrailerView)
        playTrailerView.anchor(top: movieImageView.bottomAnchor,
                                 right: self.safeAreaLayoutGuide.rightAnchor,
                                 paddingTop: -35,
                                 paddingRight: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    @objc private func didTapPlayButton() {
        delegate?.didTapPlayTrailerButton()
    }
    
}
