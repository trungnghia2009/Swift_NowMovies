//
//  Helper.swift
//  NowMovie
//
//  Created by NghiaTran on 10/06/2021.
//  Copyright © 2021 trungnghia. All rights reserved.
//

import UIKit

class Helpers {
    
    private init() {}
    
    static let shared = Helpers()
    
    func addHapticFeedback() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}
