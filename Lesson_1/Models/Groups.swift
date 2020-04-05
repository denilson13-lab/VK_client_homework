//
//  Users.swift
//  Lesson_1
//
//  Created by Denis on 04.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

class Group {
    var name: String
    var avatar: UIImage?
    var countOfPeople: Int = 100
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = UIImage(named: avatar)
    }
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.name == rhs.name && lhs.avatar =
    }
}
