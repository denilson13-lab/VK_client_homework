//
//  NetViewController.swift
//  Lesson_1
//
//  Created by Denis on 13.05.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import Alamofire

struct PhotoFinalResponse: Decodable {
    let response: PhotoItemResponse
}

struct PhotoItemResponse: Decodable {
    let items: [MyPhoto]
}

struct MyPhoto: Decodable {
    var photo = ""
    var type = ""
    
    enum FirstStageKeys: String, CodingKey {
        case sizes = "sizes"
    }
    
    enum SecondStageKeys: String, CodingKey {
        case type = "type"
        case photo = "url"
    }
    
    
    init(from decoder: Decoder) throws {
        
        let photoContainer = try decoder.container(keyedBy: FirstStageKeys.self)
        var sizesArray = try photoContainer.nestedUnkeyedContainer(forKey: .sizes)
        let sizesValue = try sizesArray.nestedContainer(keyedBy: SecondStageKeys.self)
        
        self.photo = try sizesValue.decode(String.self, forKey: .photo)
        self.type = try sizesValue.decode(String.self, forKey: .type)
    }
}

class PhotoLoader {
    
    let baseUrl = "https://api.vk.com"
    
    func loadPhoto(token: String, ownerID: Int, completion: @escaping ([MyPhoto]) -> Void ) {
        let path = "/method/photos.getAll"
        let parameters: Parameters = [
            "owner_id": ownerID,
            "access_token": token,
            "v": "5.103"
        ]
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            do {
                let photo = try JSONDecoder().decode(PhotoFinalResponse.self, from: response.value!)
                completion(photo.response.items)
                print(photo)
            } catch {
                print(error)
            }
            
        }
    }
}


