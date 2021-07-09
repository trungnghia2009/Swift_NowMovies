//
//  MovieDetailCell.swift
//  NowMovie
//
//  Created by NghiaTran on 9/29/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    
    // MARK: Properties
    static let reuseIdentifier = String(describing: MovieDetailCell.self)
    var viewModel: MovieDetailVM? {
        didSet {
            setup()
        }
    }
    
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
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [aboutLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        addSubview(stack)
        stack.anchor(top: self.topAnchor,
                     left: self.safeAreaLayoutGuide.leftAnchor,
                     bottom: self.bottomAnchor,
                     right: self.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 20,
                     paddingLeft: 12,
                     paddingBottom: 20,
                     paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    private func setup() {
        guard let viewModel = viewModel else { return }
        descriptionLabel.text = viewModel.overview
    }
}
