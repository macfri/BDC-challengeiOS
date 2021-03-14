//
//  MovieViewModel.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import Foundation


public class MovieDetailViewModel {
    
    // MARK: - Stored Properties
    private let movieManager: MovieManager
    var item: Observable<VideoDetail?> = Observable(nil)

    init(movieManager: MovieManager) {
        self.movieManager = movieManager
    }
    
    func getItem(id:Int) {
        movieManager.getMovie(id: id) { ( video ) in
            self.item.value = video
        }
    }
}
