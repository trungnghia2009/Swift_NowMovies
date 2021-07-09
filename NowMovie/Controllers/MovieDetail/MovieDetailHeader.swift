//
//  MovieDetailHeader.swift
//  NowMovie
//
//  Created by NghiaTran on 9/29/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit
import SDWebImage

protocol MovieDetailHeaderDelegate: AnyObject {
    func didTapPlayTrailerButton()
    func didTapFavoriteButton()
    func didTapShareButton()
    func didTapAlbumButton()
}

class MovieDetailHeader: UIView {
    
    // MARK: Properties
    weak var delegate: MovieDetailHeaderDelegate?
    private let viewModel: MovieDetailVM
    var isFavorite: Bool = false
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 2
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
    
    lazy var albumBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(systemName: "photo.fill.on.rectangle.fill"), for: .normal)
        btn.setDimensions(width: 40, height: 40)
        btn.addTarget(self, action: #selector(didTapAlbumButton), for: .touchUpInside)
        return btn
    }()
    
    lazy var favoriteView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 25, height: 25)
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "heart")
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFavoriteButton))
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    
    lazy var shareBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.setDimensions(width: 40, height: 40)
        btn.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        return btn
    }()
    
    // MARK: Lifecycle
    init(viewModel: MovieDetailVM) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        // Movie image
        var heightPlus: CGFloat = 0
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            heightPlus += 200
        }
        addSubview(movieImageView)
        movieImageView.setDimensions(width: UIScreen.main.bounds.width, height: 240 + heightPlus)
        movieImageView.centerX(inView: self)
        movieImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        if let url = URL(string: viewModel.detailImageUrl) {
            movieImageView.sd_setImage(with: url)
        }
        let frameSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 350 + heightPlus)
        movieImageView.addGradient(frame: frameSize, start: .clear, end: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        
        // Movie rating
        addSubview(ratingLabel)
        ratingLabel.anchor(left: self.safeAreaLayoutGuide.leftAnchor,
                           bottom: movieImageView.bottomAnchor,
                           paddingLeft: 12,
                           paddingBottom: -35)
        ratingLabel.text = viewModel.rating
        
        // Favorite button
        addSubview(favoriteView)
        favoriteView.centerY(inView: ratingLabel)
        favoriteView.anchor(left: ratingLabel.rightAnchor, paddingLeft: 10)
        
        // Movie title
        addSubview(titleLabel)
        titleLabel.anchor(top: movieImageView.bottomAnchor,
                          left: self.safeAreaLayoutGuide.leftAnchor,
                          right: self.safeAreaLayoutGuide.rightAnchor,
                          paddingTop: -50,
                          paddingLeft: 12,
                          paddingRight: 60)
        titleLabel.text = viewModel.titleAndYear
        
        // Play trailer button
        addSubview(playTrailerView)
        playTrailerView.anchor(top: movieImageView.bottomAnchor,
                               right: self.safeAreaLayoutGuide.rightAnchor,
                               paddingTop: -35,
                               paddingRight: 18)
        
        // Album button
        addSubview(albumBtn)
        albumBtn.anchor(left: titleLabel.leftAnchor, bottom: titleLabel.topAnchor, paddingBottom: 10)
        
        // Share button
        addSubview(shareBtn)
        shareBtn.centerY(inView: albumBtn)
        shareBtn.anchor(left: albumBtn.rightAnchor, paddingLeft: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    @objc private func didTapPlayButton() {
        Helpers.shared.addHapticFeedback()
        delegate?.didTapPlayTrailerButton()
    }
    
    @objc private func didTapFavoriteButton() {
        Helpers.shared.addHapticFeedback()
        isFavorite.toggle()
        isFavorite ?
            (favoriteView.image = UIImage(systemName: "heart.fill")) :
            (favoriteView.image = UIImage(systemName: "heart"))
        delegate?.didTapFavoriteButton()
    }
    
    @objc private func didTapShareButton() {
        Helpers.shared.addHapticFeedback()
        delegate?.didTapShareButton()
    }
    
    @objc private func didTapAlbumButton() {
        Helpers.shared.addHapticFeedback()
        delegate?.didTapAlbumButton()
    }
    
}
