//
//  RoundedMapButton.swift
//  DemoApp
//
//  Created by Ammad on 04/08/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//
import UIKit
@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1.0
    }
    
}
