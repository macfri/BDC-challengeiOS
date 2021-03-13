//
//  VideoManager.swift
//  3DSecure
//
//  Created by Ronald Martinez on 6/18/19.
//  Copyright Â© 2019 Ronald. All rights reserved.
//

import Foundation


public class MovieManager {
    
    public func getMovies(path: String,
                                     completion: @escaping (_ results:[VideoListResult]?) -> Void) {
        let urlString = "\(BuildConfig.ServerName())/movie/\(path)?api_key=\(BuildConfig.ApiKey())&language=en-US&page=1"
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        let url:NSURL = NSURL(string: urlString)!
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        for header in headers {request.setValue(header.value, forHTTPHeaderField: header.key)}
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print("e: ", e)
                completion(nil)
            } else {
                let dataparsing = String(bytes: data!, encoding: .utf8)
                print("dataparsing: ", dataparsing!)
                let results = try! JSONDecoder().decode(
                    VideoList.self, from: data!)
                completion(results.results!)
            }
        }
        task.resume()
    }

    public func getMovie(id: Int,
                         completion: @escaping (_ results: VideoDetail?) -> Void) {
        let urlString = "\(BuildConfig.ServerName())/movie/\(id)?api_key=\(BuildConfig.ApiKey())"
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        let url:NSURL = NSURL(string: urlString)!
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        for header in headers {request.setValue(header.value, forHTTPHeaderField: header.key)}
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print("e: ", e)
                completion(nil)
            } else {
                let dataparsing = String(bytes: data!, encoding: .utf8)
                print("dataparsing: ", dataparsing!)
                let results = try! JSONDecoder().decode(
                    VideoDetail.self, from: data!)
                completion(results)
            }
        }
        task.resume()
    }

}
