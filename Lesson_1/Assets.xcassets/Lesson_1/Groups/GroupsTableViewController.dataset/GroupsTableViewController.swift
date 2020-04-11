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
    
    var filteredGroups: [Group] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
       return searchController.isActive && !isSearchBarEmpty
     }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroups.count
        }
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        let group: Group
        if isFiltering {
            group = filteredGroups[indexPath.row]
        } else {
            group = groups[indexPath.row]
        }
        cell.groupName.text = group.name
        cell.groupPicture.image = group.avatar
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
    
    func filterContentForSearchText(_ searchText: String) {
        filteredGroups = groups.filter { (group: Group) -> Bool in
            if group.name.lowercased().contains(searchText.lowercased()) {
                return true
            } else {
                return false
            }
        }
        tableView.reloadData()
    }
}

extension GroupsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
