//
//  Users.swift
//  Lesson_1
//
//  Created by Denis on 04.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit
import Alamofire

struct FriendsFinalResponse: Decodable {
    let response: ItemResponse
}

struct ItemResponse: Decodable {
    let items: [MyFriend]
}

struct MyFriend: Decodable {
    var id = 0
    var name = ""
    var surname = ""
    var photo = ""
    
        enum SecondStageKeys: String, CodingKey {
            case id = "id"
            case name = "first_name"
            case surname = "last_name"
            case photo = "photo_200_orig"
        }
        
    init(from decoder: Decoder) throws {
        
        let frendsContainer = try decoder.container(keyedBy: SecondStageKeys.self)
        self.id = try frendsContainer.decode(Int.self, forKey: .id)
        self.name = try frendsContainer.decode(String.self, forKey: .name)
        self.surname = try frendsContainer.decode(String.self, forKey: .surname)
        self.photo = try frendsContainer.decode(String.self, forKey: .photo)
    }
}

class FriendsLoader {
    
    let baseUrl = "https://api.vk.com"
    
    func loadFriendsList(token: String, completion: @escaping ([MyFriend]) -> Void )  {
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "fields": "photo_200_orig",
            "access_token": token,
            "v": "5.103"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            do {
                let friend = try JSONDecoder().decode(FriendsFinalResponse.self, from: response.value!)
                completion(friend.response.items)
                print(friend)
            } catch {
                print(error)
            }
            
        }
    }
}
