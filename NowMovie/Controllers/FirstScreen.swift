//
//  ProfileController.swift
//  NowMovie
//
//  Created by NghiaTran on 9/15/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class FirstScreen: UIViewController {
    
    // MARK: Properties
    private let reachability = try! Reachability()
    private let networkHandling = NetworkHandling()
    
    private let actionButon: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("To Movie List", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setDimensions(width: 200, height: 50)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(actionButon)
        actionButon.centerX(inView: view)
        actionButon.centerY(inView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        networkHandling.observerInternetConnection(controller: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        networkHandling.removeObserverInternetConnection()
    }
    
    // MARK: Selectors
    @objc private func didTapButton() {
        let controller = MovieListVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    


}
