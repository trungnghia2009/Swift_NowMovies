//
//  ProfileController.swift
//  NowMovie
//
//  Created by NghiaTran on 9/15/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class FirstScreen: UIViewController {

    private let actionButon: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("To Movies List", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setDimensions(width: 200, height: 50)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(actionButon)
        actionButon.centerX(inView: view)
        actionButon.centerY(inView: view)
    }
    
    @objc private func didTapButton() {
        let controller = MovieListVC()
        navigationController?.pushViewController(controller, animated: true)
    }

}
