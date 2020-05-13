//
//  NetViewController.swift
//  Lesson_1
//
//  Created by Denis on 13.05.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit
import Alamofire

class DataLoader {
    
    let baseUrl = "https://api.vk.com"
    
    func loadFriendsList(token: String){
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "fields": "nickname",
            "access_token": token,
            "v": "5.103"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value as Any)
        }
    }
    
    func loadPhoto(token: String){
        let path = "/method/photos.getAll"
        let parameters: Parameters = [
            "access_token": token,
            "v": "5.103"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value as Any)
        }
    }
    
    func loadGroups(token: String){
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "access_token": token,
            "v": "5.103"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value as Any)
        }
    }
    
    func loadGroupsForSearch(token: String){
        let path = "/method/groups.getCatalog"
        let parameters: Parameters = [
            "access_token": token,
            "v": "5.103"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value as Any)
        }
    }
    
}
