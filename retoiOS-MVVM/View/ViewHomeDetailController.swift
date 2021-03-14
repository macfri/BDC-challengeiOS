//
//  ViewHomeDetailController.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import UIKit

class ViewHomeDetailController: UIViewController {

    // MARK: - Stored Properties
    public var paramId:Int = 0
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtCreatedBy: UILabel!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var imgLesson: UIImageView!
    @IBOutlet weak var imgNavLeft: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let movieManager = MovieManager()
        movieManager.getMovie(id: self.paramId) { ( movie ) in
            DispatchQueue.main.async {
                self.txtTitle.text = movie?.title
                self.txtDescription.text = movie?.overview
                self.txtCreatedBy.text = movie?.tagline
                if movie?.backdrop_path != nil {
                    let urlImage = "\(BuildConfig.ImageUrl())/\(movie!.backdrop_path!)"
                    URLSession.shared.dataTask(with: NSURL(string: urlImage)! as URL, completionHandler: { (data, response, error) -> Void in
                           if error != nil {
                               print(error ?? "No Error")
                               return
                           }
                           DispatchQueue.main.async(execute: { () -> Void in
                            self.imgHeader.image = UIImage(data: data!)
                            self.imgHeader.contentMode = .scaleToFill
                           })
                       }).resume()
                }
            }
        }
    
    }
    
    @IBAction func btnGoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
