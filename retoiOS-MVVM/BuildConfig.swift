//
//  BuildConfig.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import Foundation


struct BuildConfig {

    static func ApiKey() -> String { return "3ce7c621d2350bf13d2f250741a370eb" }
    static func ServerName() -> String { return "https://api.themoviedb.org/3" }
    static func ImageUrl() -> String { return "https://image.tmdb.org/t/p/w500" }
    static func reloadLoginExpiredTime() -> Int { return 60 * 5 } // 5 minutes
    static func checkSession() -> Bool { return true} // 5 minutes


}
