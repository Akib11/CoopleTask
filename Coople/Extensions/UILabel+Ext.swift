//
//  UILabel+Ext.swift
//  AppleStore
//
//  Created by Akib Quraishi on 27/09/2019.
//  Copyright © 2019 AkibiOS. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}


