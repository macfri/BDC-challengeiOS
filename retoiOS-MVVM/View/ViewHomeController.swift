//
//  ViewController.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import UIKit

class ViewHomeController: UIViewController, UICollectionViewDelegate {

    private let reuseIdentifier = "MovieCell"
    @IBOutlet weak var collectionView: UICollectionView!

//    private let viewModel = WeatherViewModel()

    
//    @IBOutlet weak var txtUsername: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!
//
//    @IBAction func btnLogin(_ sender: UIButton) {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}


// MARK: - UICollectionViewDataSource
extension ViewHomeController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
              for: indexPath)
          cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(
            withIdentifier: "ViewHomeDetailController") as! ViewHomeDetailController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
