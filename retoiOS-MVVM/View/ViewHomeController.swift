//
//  ViewHomeController.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import UIKit


class ViewHomeController: UIViewController, UICollectionViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var uiBntNav1: UIButton!
    @IBOutlet weak var uiBtnNav2: UIButton!
    @IBOutlet weak var uiBtnNav3: UIButton!
    @IBOutlet weak var uiBtnNav4: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Stored Properties
    private var tabledata:[VideoListResult] = []

    // MARK: - Stored Properties
    private var dataSource : MoviesDataSource!
    private var movieViewModel: MovieViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingMenuBar()
        self.settingColletionView()
        let movieManager = MovieManager()
        self.movieViewModel = MovieViewModel(movieManager: movieManager)
        self.movieViewModel.getItems(type: "popular")
        self.bindData()
    }
    
    private func settingColletionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 40, right: 0)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-5) / 2, height: 320)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 5
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = layout
    }
    
    private func settingMenuBar(){
        self.uiBntNav1.backgroundColor = UIColor.darkGray
        self.uiBntNav1.layer.cornerRadius = 10; // this value vary as per your desire
        self.uiBntNav1.clipsToBounds = true;
        self.uiBtnNav2.layer.cornerRadius = 10; // this value vary as per your desire
        self.uiBtnNav2.clipsToBounds = true;
        self.uiBtnNav3.layer.cornerRadius = 10; // this value vary as per your desire
        self.uiBtnNav3.clipsToBounds = true;
        self.uiBtnNav4.layer.cornerRadius = 10; // this value vary as per your desire
        self.uiBtnNav4.clipsToBounds = true;
    }
    
    func bindData() {
        movieViewModel.items.bind {  [weak self]  (videos) in
            if videos != nil {
                self?.tabledata = videos!
                self?.dataSource = MoviesDataSource(items: videos!)
                DispatchQueue.main.async {
                    self?.collectionView.dataSource = self?.dataSource!
                    self?.collectionView.reloadData()
                }
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
        self.uiBtnNav2.backgroundColor = UIColor.clear
        self.uiBtnNav3.backgroundColor = UIColor.clear
        self.uiBtnNav4.backgroundColor = UIColor.clear
        self.uiBntNav1.backgroundColor = UIColor.darkGray
        self.uiBntNav1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.movieViewModel.getItems(type: "popular")
    }

    @IBAction func btnNavSend2(_ sender: UIButton) {
        self.uiBntNav1.backgroundColor = UIColor.clear
        self.uiBtnNav3.backgroundColor = UIColor.clear
        self.uiBtnNav4.backgroundColor = UIColor.clear
        self.uiBtnNav2.backgroundColor = UIColor.darkGray
        self.uiBtnNav2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.movieViewModel.getItems(type: "top_rated")
    }
    
    @IBAction func btnNavSend3(_ sender: UIButton) {
        self.uiBntNav1.backgroundColor = UIColor.clear
        self.uiBtnNav2.backgroundColor = UIColor.clear
        self.uiBtnNav4.backgroundColor = UIColor.clear
        self.uiBtnNav3.backgroundColor = UIColor.darkGray
        self.uiBtnNav3.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.movieViewModel.getItems(type: "upcoming")
    }

    @IBAction func btnNavSend4(_ sender: UIButton) {
        self.uiBntNav1.backgroundColor = UIColor.clear
        self.uiBtnNav2.backgroundColor = UIColor.clear
        self.uiBtnNav3.backgroundColor = UIColor.clear
        self.uiBtnNav4.backgroundColor = UIColor.darkGray
        self.uiBtnNav4.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.movieViewModel.getItems(type: "now_playing")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = tabledata[indexPath.row]
        self.goToDetail(paramId: row.id!)
    }
}
