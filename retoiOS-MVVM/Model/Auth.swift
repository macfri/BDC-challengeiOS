//
//  Auth.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import Foundation


struct Credentials {
    var username: String = ""
    var password: String = ""
}

struct ResponseValidateWithLogin: Codable {
    var success:Bool?
    var expires_at:String?
    var request_token:String?
    var status_code:Int?
    var status_message:String?
}

struct ResponseToken: Codable {
    let success:Bool
    let expires_at:String
    let request_token:String
}
