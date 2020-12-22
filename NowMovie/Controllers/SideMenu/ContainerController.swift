//
//  ContainerController.swift
//  NowMovie
//
//  Created by NghiaTran on 22/12/2020.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    // MARK: Properties
    private var movieListVC: UIViewController!
    private var menuVC: MenuVC!
    private var blackView = UIView()
    private var isHideStatusBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .default
        configureMovieListVC()
        configureMenuController()
    }
    
    // MARK: Helpers
    private func configureMovieListVC() {
        let controller = MovieListVC()
        controller.delegate = self
        movieListVC = UINavigationController(rootViewController: controller)
        addChild(movieListVC)
        movieListVC.didMove(toParent: self)
        view.addSubview(movieListVC.view)
    }
    
    private func configureMenuController() {
        menuVC = MenuVC()
        let nav = UINavigationController(rootViewController: menuVC)
        nav.didMove(toParent: self)
        view.insertSubview(nav.view, at: 0)
        configureBlackView()
    }
    
    private func configureBlackView() {
        blackView.frame = view.bounds
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.alpha = 0
        movieListVC.view.addSubview(blackView)
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        blackView.addGestureRecognizer(tap)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleBlackViewLeftSwipe))
        leftSwipe.direction = .left
        blackView.addGestureRecognizer(leftSwipe)
    }
    
    private func animateMenu(shouldExpand: Bool, completion: ((Bool) -> Void)? = nil) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.movieListVC.view.frame.origin.x = self.view.frame.width - 80
                self.blackView.alpha = 1
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.movieListVC.view.frame.origin.x = 0
                self.blackView.alpha = 0
            }, completion: completion)
        }
        
        animateStatusBar()
    }
    
    private func animateStatusBar() {
        UIView.animate(withDuration: 0.1) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private func presentMenu() {
        isHideStatusBar = true
        animateMenu(shouldExpand: true)
    }
    
    // MARK: Selectors
    @objc private func dismissMenu() {
        print("Debug: handle dismissMenu....")
        isHideStatusBar = false
        animateMenu(shouldExpand: false)
    }
    
    @objc private func handleBlackViewLeftSwipe(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            animateMenu(shouldExpand: false)
        }
    }
    

}

// MARK: MovieListVCDelegate
extension ContainerController: MovieListVCDelegate {
    func didTapMenuButton() {
        presentMenu()
    }
    
    
}
