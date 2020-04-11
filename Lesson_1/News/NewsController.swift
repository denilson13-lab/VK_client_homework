//
//  NewsController.swift
//  Lesson_1
//
//  Created by Denis on 11.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit


class NewsController: UITableViewController {
    
    var newsArray: [News] = [
        News(avatar: "munch",
             name: "Эдвард Мунк",
             surname: "",
             time: "сегодня 15:31",
             story: "Я шёл по тропинке с двумя друзьями. Солнце садилось - неожиданно небо стало кроваво-красным, я приостановился, чувствуя изнеможение, и опёрся о забор. Я смотрел на кровь и языки пламени над синевато-чёрным фьордом и городом. Мои друзья пошли дальше, а я стоял, дрожа от волнения, ощущая бесконечный крик, пронзающий природу.",
             picture: "scream",
             likes: "118",
             comments: "14",
             share: "29",
             views: "546"),
        News(avatar: "dali",
             name: "Сальвадор Дали",
             surname: "",
             time: "сегодня 14:13",
             story: "Эта небольшая картина, вероятно, самая известная работа Дали. Размягченность висящих и стекающих часов — образ, выражающий уход от линейного понимания времени.",
             picture: "memory",
             likes: "289",
             comments: "28",
             share: "34",
             views: "495")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let news: News
        news = newsArray[indexPath.row]
        cell.avatar.image = news.avatar
        cell.name.text = news.name
        cell.time.text = news.time
        cell.story.text = news.story
        cell.newsImage.image = news.picture
        cell.likes.text = news.likes
        cell.comments.text = news.comments
        cell.shares.text = news.share
        cell.views.text = news.views
        return cell
    }
}

final class RoundImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
