//
//  MovieViewModel.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import Foundation


public class MovieViewModel {
    
    // MARK: - Stored Properties
    private let movieManager: MovieManager
    var items: Observable<[VideoListResult]?> = Observable(nil)
    
    init(movieManager: MovieManager) {
        self.movieManager = movieManager
    }
    
    func getItems(type:String) {
        movieManager.getMovies(path: type) { ( videos ) in
            self.items.value = videos
        }
    }
}
