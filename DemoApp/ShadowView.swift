//
//  ShadowView.swift
//  DemoApp
//
//  Created by Ammad on 04/08/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 2.0;
        
        self.layer.shadowColor = UIColor(red: 157.0 / 255.0, green: 157.0 / 255.0, blue: 157.0 / 255.0, alpha: 0.8).cgColor
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }

}
