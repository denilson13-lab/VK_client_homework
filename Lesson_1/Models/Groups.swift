//
//  Users.swift
//  Lesson_1
//
//  Created by Denis on 04.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

struct GroupsFinalResponse: Decodable {
    let response: GroupItem
}

struct GroupItem: Decodable {
    let items: [MyGroup]
}

class MyGroup: Object,  Decodable {
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    
    enum FirstStageKeys: String, CodingKey {
        case name = "name"
        case photo = "photo_50"
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let groupsContainer = try decoder.container(keyedBy: FirstStageKeys.self)
        self.name = try groupsContainer.decode(String.self, forKey: .name)
        self.photo = try groupsContainer.decode(String.self, forKey: .photo)
    }
    
}

class GroupsLoader {
    
    let baseUrl = "https://api.vk.com"
    
    func loadGroups(token: String, completion: @escaping () -> Void ){
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "extended": "1",
            "access_token": token,
            "v": "5.103"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            
            do {
                let group = try JSONDecoder().decode(GroupsFinalResponse.self, from: response.value!)
                self?.saveGroupsData(group.response.items )
                completion()
                print(group)
            } catch {
                print(error)
            }
            
        }
    }
    
    func saveGroupsData(_ groups: [MyGroup]) {
        do {
            let realm = try Realm()
            let oldGroupsData = realm.objects(MyGroup.self)
            realm.beginWrite()
            realm.delete(oldGroupsData)
            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    
}




/// TO DELETE
class Group {
    var name: String
    var avatar: UIImage?
    var countOfPeople: Int = 100
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = UIImage(named: avatar)
    }
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.name == rhs.name && lhs.avatar == rhs.avatar
    }
}
