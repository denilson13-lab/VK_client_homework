//
//  roundFriend.swift
//  Lesson_1
//
//  Created by Denis on 04.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

final class RoundFriend2: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}

final class ShadowFriend: UIView {
    
    @IBInspectable
    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}



