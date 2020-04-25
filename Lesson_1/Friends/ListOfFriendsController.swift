//
//  ListOfFriendsController.swift
//  Lesson_1
//
//  Created by Denis on 31.03.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

struct Section <T> {
    var title: String
    var items: [T]
}

class ListOfFriendsController: UITableViewController {
    
    
    let users: [User] = [
        User(name: "Леонардо", surname: "Да Винчи", avatar: "daVinci"),
        User(name: "Клод", surname: "Моне", avatar: "mone"),
        User(name: "Эдвард", surname: "Мунк", avatar: "munch"),
        User(name: "Сальвадор", surname: "Дали", avatar: "dali"),
    ]
    
    var filteredUsers: [User] = []
    
    var usersSection = [Section<User>]()
    
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
        
        let usersDic = Dictionary.init(grouping: users) {$0.surname.prefix(1)}
        usersSection = usersDic.map {Section(title: String($0.key), items: $0.value)}
        usersSection.sort {$0.title < $1.title}
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        isFiltering ? 1 : usersSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredUsers.count : usersSection[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        let user: User = isFiltering ? filteredUsers[indexPath.row] : usersSection[indexPath.section].items[indexPath.row]
        cell.friendName.text = "\(user.name) \(user.surname)"
        cell.friendFoto.image = user.avatar
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "friendProfile" else { return }
        guard let destination = segue.destination as? FriendsCollectionViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            let user: User = isFiltering ? filteredUsers[indexPath.row] : usersSection[indexPath.section].items[indexPath.row]
            destination.photos = user.photos
            destination.title = "\(user.name) \(user.surname)"
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredUsers = users.filter { (user: User) -> Bool in
            return (user.name + user.surname).lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        isFiltering ? "" : usersSection[section].title
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        label.text = usersSection[section].title
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
        ])
        return headerView
    }
}

extension ListOfFriendsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
//
//extension ListOfFriendsController: UIViewControllerTransitioningDelegate {
//    func animationController(
//        forPresented presented: UIViewController,
//        presenting: UIViewController,
//        source: UIViewController
//    ) -> UIViewControllerAnimatedTransitioning? {
//        return Animator()
//    }
//
//    func animationController(
//        forDismissed dismissed: UIViewController
//    ) -> UIViewControllerAnimatedTransitioning? {
//        return Animator()
//    }
//}

