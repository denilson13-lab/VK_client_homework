//
//  News.swift
//  Lesson_1
//
//  Created by Denis on 11.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import Foundation

import UIKit

class News {
    var avatar: UIImage?
    var name: String
    var surname: String
    var time: String
    var story: String
    var picture: UIImage?
    var likes: String
    var comments: String
    var share: String
    var views: String
    
    init(
        avatar: String,
        name: String,
        surname: String,
        time: String,
        story: String,
        picture: String,
        likes: String,
        comments: String,
        share: String,
        views: String) {
        
        self.avatar = UIImage(named: avatar)
        self.name = name
        self.surname = surname
        self.time = time
        self.story = story
        self.picture = UIImage(named: picture)
        self.likes = likes
        self.comments = comments
        self.share = share
        self.views = views
    }
}