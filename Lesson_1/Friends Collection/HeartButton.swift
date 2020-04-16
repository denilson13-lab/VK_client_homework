//
//  Heart.swift
//  Lesson_1
//
//  Created by Denis on 05.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

class Heart: UIView {

    var heart = UIButton()
    var heartCount = UILabel()
   
    override func awakeFromNib() {
         heart = UIButton(type: .roundedRect)
         heart.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
         heart.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
         heart.setBackgroundImage(UIImage(named: "heartEmpty"), for: .normal)
         self.addSubview(heart)
    
    
         let labelFrame = CGRect(x: 27, y: 2, width: 30, height: 30)
         heartCount.frame = labelFrame
         heartCount.text = "0"
         self.addSubview(heartCount)
    }
    
    @objc func buttonIsTapped(sender: UIButton) {
        
        if heartCount.text == "0" {
            UIView.transition(with: heartCount,
                              duration: 1.2,
                              options: .transitionFlipFromLeft,
                              animations: {
                                self.heartCount.text = "1"
            })
            heartCount.textColor = .red
            heart.setBackgroundImage(UIImage(named: "heartFilled"), for: .normal)}
        else {
            UIView.transition(with: heartCount,
                              duration: 1.2,
                              options: .transitionFlipFromRight,
                              animations: {
                                self.heartCount.text = "0"
            })
            heartCount.textColor = .black
            heart.setBackgroundImage(UIImage(named: "heartEmpty"), for: .normal)}
    }
}
