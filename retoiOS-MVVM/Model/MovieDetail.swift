//
//  MovieDetail.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/13/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import Foundation


public struct VideoDetail: Codable {
    var adult:Bool?
    var backdrop_path:String?
    var belongs_to_collection:String?
    var budget:Int?
    var genres:[VideoDetailGenres]?
    var homepage:String?
    var id:Int?
    var imdb_id:Int?
    var original_language:String?
    var original_title:String?
    var overview:String?
    var popularity:Double?
    var poster_path :String?
    var production_companies :[VideoDetailCompanies]?
    var production_countries :[VideoDetailCounties]?
    var release_date:String?
    var revenue:Int?
    var runtime:Int?
    var spoken_languages:[VideoDetailSpokenLanguages]?
    var status:String?
    var tagline:String?
    var title:String?
    var video:Bool?
    var vote_average:Float?
    var vote_count:Int?
}

public struct VideoDetailCompanies: Codable {
    var id:Int?
    var logo_path:String?
    var name:String?
    var origin_country:String?
}

public struct VideoDetailCounties: Codable {
    var iso_3166_1:String?
    var name:String?
}

public struct VideoDetailSpokenLanguages: Codable {
    var english_name:String?
    var iso_639_1:String?
    var name:String?
}

public struct VideoDetailGenres: Codable {
    var id:String?
    var name:String?
}
