//
//  ListOfFriendsController.swift
//  Lesson_1
//
//  Created by Denis on 31.03.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

class ListOfFriendsController: UITableViewController {
    
    
    var users: [User] = [
        User(name: "Леонардо", surname: "Да Винчи", avatar: "daVinci", origin: .Italy),
        User(name: "Клод", surname: "Моне", avatar: "mone", origin: .France),
        User(name: "Эдвард", surname: "Мунк", avatar: "munch", origin: .Norway),
        User(name: "Сальвадор", surname: "Дали", avatar: "dali", origin: .Spain),
    ]
    
    var filteredUsers: [User] = []
    
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
        searchController.searchBar.placeholder = "Найти друзей"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredUsers.count
        }
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        let user: User
        if isFiltering {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        cell.friendName.text = "\(user.name) \(user.surname)"
        cell.friendFoto.image = user.avatar
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "friendProfile" else { return }
        guard let destination = segue.destination as? FriendsCollectionViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            let user: User
            if isFiltering {
                user = filteredUsers[indexPath.row]
            } else {
                user = users[indexPath.row]
            }
            destination.photos = user.photos
            destination.title = "\(user.name) \(user.surname)"
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredUsers = users.filter {
            (user: User) -> Bool in
            if user.name.lowercased().contains(searchText.lowercased()) ||
            user.surname.lowercased().contains(searchText.lowercased()) {
                return true
            } else {
                return false
            }
        }
        tableView.reloadData()
    }
}

extension ListOfFriendsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}


