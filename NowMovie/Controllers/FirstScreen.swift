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
    
    private lazy var noWifiImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 200, height: 200)
        iv.image = UIImage(systemName: "wifi.slash")
        iv.contentMode = .scaleAspectFit
        iv.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRefreshPage))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGesture)

        return iv
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(actionButon)
        actionButon.centerX(inView: view)
        actionButon.centerY(inView: view)
        
        view.addSubview(noWifiImageView)
        noWifiImageView.centerX(inView: view)
        noWifiImageView.centerY(inView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        observerInternetConnection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        removeObserverInternetConnection()
    }
    
    
    // MARK: Helpers
    private func observerInternetConnection() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func removeObserverInternetConnection() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    // MARK: Selectors
    @objc private func didTapButton() {
        let controller = MovieListVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
            actionButon.isHidden = false
            noWifiImageView.isHidden = true
        case .cellular:
            print("Cellular Connection")
        case .unavailable:
            print("No Connection")
            actionButon.isHidden = true
            noWifiImageView.isHidden = false
        case .none:
            print("No Connection")
        }
    }
    
    @objc private func didTapRefreshPage() {
        print("Did tap refersh button...")
        removeObserverInternetConnection()
        observerInternetConnection()
    }

}
