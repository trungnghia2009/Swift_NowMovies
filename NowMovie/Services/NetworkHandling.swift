//
//  NetworkHandling.swift
//  NowMovie
//
//  Created by NghiaTran on 10/20/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class NetworkHandling {
    
    private let reachability = try! Reachability()
    private var controller = UIViewController()
    private var dismiss = false
    
    func observerInternetConnection(controller: UIViewController, dismiss: Bool = false) {
        self.controller = controller
        self.dismiss = dismiss
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func removeObserverInternetConnection() {
        print("Remove internet observer")
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    private func navigateToInternetErrorScreen() {
        let storyboard = UIStoryboard(name: "InternetConnectErrorHandling", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "internet") as! InternetConnectErrorHandling
        controller.present(vc, animated: true, completion: nil)
    }
    
    @objc private func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
            if dismiss { controller.dismiss(animated: true) }
        case .cellular:
            print("Cellular Connection")
            if dismiss { controller.dismiss(animated: true) }
        case .unavailable, .none:
            print("No Connection")
            if !dismiss { navigateToInternetErrorScreen() }
        }
    }
    
}
