//
//  InternetConnectErrorHandling.swift
//  NowMovie
//
//  Created by NghiaTran on 10/20/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class InternetConnectErrorHandling: UIViewController {
    
    // MARK: Properties
    @IBOutlet var lineView: UIView!
    private let networkHandling = NetworkHandling()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lineView.layer.cornerRadius = 5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkHandling.observerInternetConnection(controller: self, dismiss: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        networkHandling.removeObserverInternetConnection()
    }
    
    // MARK: IBAction
    @IBAction func didTapSettingWifi(_ sender: UIButton) {
        guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingUrl, options: [:], completionHandler: nil)
        print("Go to Setting...")
    }
    

}
