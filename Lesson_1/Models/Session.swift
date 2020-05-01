//
//  Session.swift
//  Lesson_1
//
//  Created by Denis on 01.05.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import Foundation

class Session {
    
    private init(){}
    static let instance = Session()
    
    var name: String = ""
    var userId: Int = 0
    var token: String = ""
    
}
