//
//  NewsCell.swift
//  Lesson_1
//
//  Created by Denis on 11.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var story: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var shares: UILabel!
    @IBOutlet weak var views: UILabel!
}
