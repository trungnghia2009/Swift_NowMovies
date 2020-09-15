//
//  MovieListCell.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {

    // MARK: - Properties
    static let reuseIdentifier = String(describing: MovieListCell.self)
    
    var viewModel: MovieDetailVM? {
        didSet {
            setup()
        }
    }
    
    private let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.setDimensions(width: 47, height: 70)
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor  = .secondaryLabel
        return label
    }()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(movieImageView)
        movieImageView.centerY(inView: self, left: self.safeAreaLayoutGuide.leftAnchor, paddingLeft: 24)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, ratingLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        addSubview(stack)
        stack.centerY(inView: movieImageView, left: movieImageView.rightAnchor, paddingLeft: 12)
        stack.anchor(right: self.rightAnchor, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    private func setup() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        ratingLabel.text = viewModel.rating
        if let url = URL(string: viewModel.coverImageURL) {
            movieImageView.load(url: url)
        }
    }
}
