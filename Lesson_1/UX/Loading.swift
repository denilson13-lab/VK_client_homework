
//  Loading.swift
//  Lesson_1
//
//  Created by Denis on 17.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.



import UIKit

class Loading: UIViewController {
    
    @IBOutlet weak var first: UIView!
    @IBOutlet weak var second: UIView!
    @IBOutlet weak var third: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
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
            self.performSegue(withIdentifier: "Next", sender: self)
        })
    }
}
