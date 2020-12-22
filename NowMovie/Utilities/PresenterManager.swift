//
//  PresenterManager.swift
//  NowMovie
//
//  Created by NghiaTran on 22/12/2020.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class PresenterManager {
    
    static let shared = PresenterManager()
    
    private init() {}
    
    enum VC {
        case containerController
        case firstScreenController
        case movieListController
    }
    
    func show(vc: VC) {
        var viewController: UIViewController
        
        switch vc {
        case .containerController:
            viewController = ContainerController()
        case .firstScreenController:
            viewController = FirstScreen()
        case .movieListController:
            viewController = UINavigationController(rootViewController: MovieListVC())
        }
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
