//
//  MoviesDataSource.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//
import Foundation
import UIKit


class MoviesDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Stored Properties
    private let reuseIdentifier = "cell"
    private let itemsPerRow: CGFloat = 2
    private var items:[VideoListResult] = []

    init(items : [VideoListResult]) {
        self.items =  items
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionMovieViewCell
        let row = self.items[indexPath.row]
        cell.title.text = row.title
        cell.backgroundColor = .black
        cell.date.text = row.release_date
        cell.points.text = "\(row.vote_average!)"
        cell.title.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        cell.image.layer.cornerRadius = 10
        cell.image.clipsToBounds = true
        
        DispatchQueue.main.async {
            if row.poster_path != nil {
                let urlImage = "\(BuildConfig.ImageUrl())/\(row.poster_path!)"
                URLSession.shared.dataTask(with: NSURL(string: urlImage)! as URL, completionHandler: { (data, response, error) -> Void in
                       if error != nil {
                           print(error ?? "No Error")
                           return
                       }
                       DispatchQueue.main.async(execute: { () -> Void in
                        cell.image.image = UIImage(data: data!)
                        cell.image.contentMode = .scaleToFill
                       })
                   }).resume()
            }
        }
        return cell
    }
}
