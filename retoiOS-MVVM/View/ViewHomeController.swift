//
//  ViewHomeController.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import UIKit


class MyCollectionMovieViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var image: UIImageView!
}

class ViewHomeController: UIViewController, UICollectionViewDelegate {

    //MARK: - IBOutlets
    @IBOutlet weak var uiBntNav1: UIButton!
    @IBOutlet weak var uiBtnNav2: UIButton!
    @IBOutlet weak var uiBtnNav3: UIButton!
    @IBOutlet weak var uiBtnNav4: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Stored Properties
    private var screenSize: CGRect!
    private var screenWidth: CGFloat!
    private var screenHeight: CGFloat!

    private let reuseIdentifier = "cell"
    private let itemsPerRow: CGFloat = 2
    private var tabledata:[VideoListResult] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.uiBntNav1.backgroundColor = UIColor.darkGray
        self.uiBntNav1.layer.cornerRadius = 10; // this value vary as per your desire
        self.uiBntNav1.clipsToBounds = true;
        self.uiBtnNav2.layer.cornerRadius = 10; // this value vary as per your desire
        self.uiBtnNav2.clipsToBounds = true;
        self.uiBtnNav3.layer.cornerRadius = 10; // this value vary as per your desire
        self.uiBtnNav3.clipsToBounds = true;
        self.uiBtnNav4.layer.cornerRadius = 10; // this value vary as per your desire
        self.uiBtnNav4.clipsToBounds = true;
    
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
    
    private func goToDetail(paramId:Int){
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(
            withIdentifier: "ViewHomeDetailController") as! ViewHomeDetailController
        vc.paramId = paramId

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnNavSend1(_ sender: UIButton) {
    
        self.uiBntNav1.backgroundColor = UIColor.darkGray
        self.uiBntNav1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)

        self.uiBtnNav2.backgroundColor = UIColor.clear
        self.uiBtnNav3.backgroundColor = UIColor.clear
        self.uiBtnNav4.backgroundColor = UIColor.clear

        let movieManager = MovieManager()
        movieManager.getMovies(path: "popular") { ( videos ) in
            self.tabledata = videos!
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    @IBAction func btnNavSend2(_ sender: UIButton) {
        self.uiBntNav1.backgroundColor = UIColor.clear
        self.uiBtnNav3.backgroundColor = UIColor.clear
        self.uiBtnNav4.backgroundColor = UIColor.clear

        let movieManager = MovieManager()
        movieManager.getMovies(path: "top_rated") { ( videos ) in
            self.tabledata = videos!
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.uiBtnNav2.backgroundColor = UIColor.darkGray
        self.uiBtnNav2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    @IBAction func btnNavSend3(_ sender: UIButton) {
        self.uiBntNav1.backgroundColor = UIColor.clear
        self.uiBtnNav2.backgroundColor = UIColor.clear
        self.uiBtnNav4.backgroundColor = UIColor.clear

        let movieManager = MovieManager()
        movieManager.getMovies(path: "upcoming") { ( videos ) in
            self.tabledata = videos!
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.uiBtnNav3.backgroundColor = UIColor.darkGray
        self.uiBtnNav3.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    }

    @IBAction func btnNavSend4(_ sender: UIButton) {
        self.uiBntNav1.backgroundColor = UIColor.clear
        self.uiBtnNav2.backgroundColor = UIColor.clear
        self.uiBtnNav3.backgroundColor = UIColor.clear

        let movieManager = MovieManager()
        movieManager.getMovies(path: "now_playing") { ( videos ) in
            self.tabledata = videos!
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.uiBtnNav4.backgroundColor = UIColor.darkGray
        self.uiBtnNav4.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
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
        let row = tabledata[indexPath.row]
        self.goToDetail(paramId: row.id!)
    }

}
