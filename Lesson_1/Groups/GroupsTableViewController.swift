//
//  GroupsTableViewController.swift
//  Lesson_1
//
//  Created by Denis on 01.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    let groupsLoader = GroupsLoader()
    let session = Session.instance
//    var myGroups = [MyGroup]()
    var myGroups: Results<MyGroup>?
    var token: NotificationToken?
    
    var filteredGroups: [MyGroup] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsLoader.loadGroups(token: session.token)
        pairTableAndRealm()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        myGroups = realm.objects(MyGroup.self)
        token = myGroups!.observe { [weak self] (changes: RealmCollectionChange) in
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
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroups.count
        }
        return myGroups!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        let group: MyGroup
        if isFiltering {
            group = filteredGroups[indexPath.row]
        } else {
            group = myGroups![indexPath.row]
        }
        cell.groupName.text = group.name
        
        let session = URLSession.shared
        let groupPhotoUrl = group.photo
        session.downloadTask(with: URL(string: groupPhotoUrl)!) { (url, response, error) in
            let data = try! Data(contentsOf: url!)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.groupPicture.image = image
            }
        }.resume()
        
        return cell
    }
    
    //    @IBAction func addGroup(segue: UIStoryboardSegue) {
    //            if segue.identifier == "addGroup" {
    //                let Group_Select_TableViewController = segue.source as! Group_Select_TableViewController
    //                if let indexPath = Group_Select_TableViewController.tableView.indexPathForSelectedRow {
    //                    let group = Group_Select_TableViewController.group[indexPath.row]
    //                    if !groups.contains(group) {
    //                        groups.append(group)
    //                        tableView.reloadData()
    //                    }
    //                }
    //            }
    //    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            myGroups.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredGroups = myGroups!.filter { (group: MyGroup) -> Bool in
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
