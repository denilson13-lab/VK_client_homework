//
//  FriendsCollectionViewController.swift
//  Lesson_1
//
//  Created by Denis on 01.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: UICollectionViewController {
    
    var ownerID = 0
    
    let photoLoader = PhotoLoader()
    let session = Session.instance
    var myPhotos = [MyPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromRealm()
        photoLoader.loadPhoto(token: session.token, ownerID: ownerID) { [weak self] in
            self?.loadFromRealm()
        }
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func loadFromRealm() {
        do {
            let realm = try Realm()
            let myPhotos = realm.objects(MyPhoto.self).filter("photoSetId == %@", ownerID)
            self.myPhotos = Array(myPhotos)
            self.collectionView.reloadData()
        } catch {
            print(error)
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCollectionViewCell", for: indexPath) as! FriendsCollectionViewCell
        
        let user = myPhotos[indexPath.row]
        
        let session = URLSession.shared
        let userPhotoUrl = user.photo
        session.downloadTask(with: URL(string: userPhotoUrl)!) { (url, response, error) in
            let data = try! Data(contentsOf: url!)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.largeFoto.image = image
            }
        }.resume()
        
        return cell
    }
}

extension FriendsCollectionViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 10) / 2
            return CGSize(width: width, height: width)
        }
}
