//
//  LoadingScreen.swift
//  Lesson_1
//
//  Created by Denis on 14.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

class LoadingScreen: UIViewController {
    @IBOutlet weak var first: UIView!
    @IBOutlet weak var second: UIView!
    @IBOutlet weak var third: UIView!
    @IBOutlet weak var enter: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enter.alpha = 0
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: [.repeat, .autoreverse],
            animations: {self.first.alpha -= 1},
            completion: { _ in self.first.alpha += 1
        })
        UIView.animate(
            withDuration: 1.0,
            delay: 0.5,
            options: [.repeat, .autoreverse],
            animations: {self.second.alpha -= 1},
            completion: { _ in self.second.alpha += 1
        })
        UIView.animate(
            withDuration: 1.0,
            delay: 1.0,
            options: [.repeat, .autoreverse],
            animations: {self.third.alpha -= 1},
            completion: { _ in self.third.alpha += 1
        })
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3, execute: {
            self.first.layer.removeAllAnimations()
            self.second.layer.removeAllAnimations()
            self.third.layer.removeAllAnimations()
        })
        UIView.animate(
            withDuration: 1.0,
            delay: 3.0,
            animations: {self.enter.alpha += 1}
        )
    }
}


