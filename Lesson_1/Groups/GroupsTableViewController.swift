//
//  GroupsTableViewController.swift
//  Lesson_1
//
//  Created by Denis on 01.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    var groups: [Group] = [
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
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        let selectedGroup = groups[indexPath.row]
        cell.groupName.text = selectedGroup.name
        cell.groupPicture.image = selectedGroup.avatar
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
            if segue.identifier == "addGroup" {
                let Group_Select_TableViewController = segue.source as! Group_Select_TableViewController
                if let indexPath = Group_Select_TableViewController.tableView.indexPathForSelectedRow {
                    let group = Group_Select_TableViewController.group[indexPath.row]
                    if !groups.contains(group) {
                        groups.append(group)
                        tableView.reloadData()
                    }
                }
            }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}

