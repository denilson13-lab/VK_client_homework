//
//  Group_Select_TableViewController.swift
//  Lesson_1
//
//  Created by Denis on 02.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

class Group_Select_TableViewController: UITableViewController {

    var group: [Group] = [
          Group(name: "Ученые", avatar: "scientists"),
          Group(name: "Писатели", avatar: "authors"),
          Group(name: "Доктора", avatar: "medics"),
          Group(name: "Художники", avatar: "artists"),
          Group(name: "Скульпторы", avatar: "sculpture"),
      ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTo_Select_TableViewCell", for: indexPath) as! GroupTo_Select_TableViewCell
        let selectedGroup = group[indexPath.row]
        cell.groupTo_select.text = selectedGroup.name
        cell.groupTo_selectPicture.image = selectedGroup.avatar
        return cell
    }

}
