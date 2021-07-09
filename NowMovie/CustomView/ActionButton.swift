//
//  ActionButton.swift
//  NowMovie
//
//  Created by trungnghia on 09/07/2021.
//  Copyright © 2021 trungnghia. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchUp() {
        Helpers.shared.addHapticFeedback()
    }
}
