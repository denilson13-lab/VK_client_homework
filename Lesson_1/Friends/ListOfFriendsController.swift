//
//  ListOfFriendsController.swift
//  Lesson_1
//
//  Created by Denis on 31.03.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit
import AlamofireImage
import RealmSwift

//struct Section <T> {
//    var title: String
//    var items: [T]
//}

class ListOfFriendsController: UITableViewController {
    
    let dataLoader = FriendsLoader()
    let session = Session.instance
//    var myFriends = [MyFriend]()
    
    var myFriends: Results<MyFriend>?
    var token: NotificationToken?

    
    var filteredUsers: [MyFriend] = []
//    var usersSection = [Section<MyFriend>]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataLoader.loadFriendsList(token: session.token)
        pairTableAndRealm()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
//        let usersDic = Dictionary.init(grouping: myFriends) {$0.name.prefix(1)}
//        usersSection = usersDic.map {Section(title: String($0.key), items: $0.value)}
//        usersSection.sort {$0.title < $1.title}
    }
    

    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        myFriends = realm.objects(MyFriend.self)
        token = myFriends!.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }


    
//    func loadFromRealm() {
//        do {
//            let realm = try Realm()
//            let myFriends = realm.objects(MyFriend.self)
//            self.myFriends = Array(myFriends)
//            self.tableView.reloadData()
//        } catch {
//            print(error)
//        }
//    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
//        isFiltering ? 1 : usersSection.count
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        isFiltering ? filteredUsers.count : usersSection[section].items.count
        isFiltering ? filteredUsers.count : myFriends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        let user: MyFriend = isFiltering ? filteredUsers[indexPath.row] : myFriends![indexPath.row]
//        let user: MyFriend = isFiltering ? filteredUsers[indexPath.row] : usersSection[indexPath.section].items[indexPath.row]
        
        cell.friendName.text = "\(user.name) \(user.surname)"
        
        if let photoUrl = URL(string: user.photo) {
            cell.friendFoto.af.setImage(withURL: photoUrl)
        }
        
        return cell
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "friendProfile" else { return }
            guard let destination = segue.destination as? FriendsCollectionViewController else { return }
            if let indexPath = tableView.indexPathForSelectedRow {
//                let user: MyFriend = isFiltering ? filteredUsers[indexPath.row] : usersSection[indexPath.section].items[indexPath.row]
                let user: MyFriend = isFiltering ? filteredUsers[indexPath.row] : myFriends![indexPath.row]
                destination.ownerID = user.id
            }
        }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredUsers = myFriends!.filter { (user: MyFriend) -> Bool in
            return (user.name + user.surname).lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
//        isFiltering ? "" : usersSection[section].title
//    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        let label = UILabel()
//        headerView.backgroundColor = UIColor.systemGray5
//        label.text = usersSection[section].title
//        label.textColor = UIColor.black
//        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
//        headerView.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
//        ])
//        return headerView
//    }
}

extension ListOfFriendsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}


