//
//  ProfileController.swift
//  NowMovie
//
//  Created by NghiaTran on 9/15/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit
import Lottie

class FirstScreen: UIViewController {
    
    // MARK: Properties
    private let reachability = try! Reachability()
    private let networkHandling = NetworkHandling()
    private let heartAnimationView = AnimationView(animation: Animation.named("love"))
    
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

        setupGradientLayer(fromColor: .white, toColor: .red)
        
        view.addSubview(actionButon)
        actionButon.centerX(inView: view)
        actionButon.centerY(inView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        createWatermelonAnimation()
        networkHandling.observerInternetConnection(controller: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        heartAnimationView.stop()
        networkHandling.removeObserverInternetConnection()
    }
    
    private func createWatermelonAnimation() {
        heartAnimationView.animationSpeed = 2
        heartAnimationView.loopMode = .loop
        heartAnimationView.contentMode = .scaleAspectFit
        heartAnimationView.frame = CGRect(x: (view.frame.size.width - 200) / 2, y: 50, width: 200, height: 200)
        view.addSubview(heartAnimationView)
        heartAnimationView.play()
    }
    
    // MARK: Selectors
    @objc private func didTapButton() {
        let controller = MovieListVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    


}
