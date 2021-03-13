//
//  ViewController.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import UIKit


class MyCollectionMovieViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var image: UIImageView!
}

class ViewHomeController: UIViewController, UICollectionViewDelegate {

    // MARK: - Stored Properties
    private let reuseIdentifier = "cell"
    private let itemsPerRow: CGFloat = 2
    private var tabledata:[VideoListResult] = []
    private var screenSize: CGRect!
    private var screenWidth: CGFloat!
    private var screenHeight: CGFloat!

    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 40, right: 0)
        layout.itemSize = CGSize(width: (screenWidth-5) / itemsPerRow, height: 320)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 5
        self.collectionView.collectionViewLayout = layout

        let movieManager = MovieManager()
        movieManager.getMovies(path: "popular") { ( videos ) in
            self.tabledata = videos!
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func goToDetail(){
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(
            withIdentifier: "ViewHomeDetailController") as! ViewHomeDetailController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UICollectionViewDataSource
extension ViewHomeController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return tabledata.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MyCollectionMovieViewCell
        let row = tabledata[indexPath.row]
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.goToDetail()
    }

}
