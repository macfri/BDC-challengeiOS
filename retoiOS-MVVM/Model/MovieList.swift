//
//  Movie.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import Foundation


public struct VideoList: Codable {
    var dates:VideoListDates?
    var page:Int?
    var results:[VideoListResult]?
    var total_pages:Int?
    var total_results:Int?
}

public struct VideoListDates: Codable {
    var maximum:Bool?
    var minimum:String?
}

public struct VideoListResult: Codable {
    var adult:Bool?
    var backdrop_path:String?
    var genre_ids:[Int]?
    var id:Int?
    var original_language:String?
    var original_title:String?
    var overview:String?
    var popularity:Double?
    var poster_path :String?
    var release_date:String?
    var title:String?
    var video:Bool?
    var vote_average:Float?
    var vote_count:Int?
}
