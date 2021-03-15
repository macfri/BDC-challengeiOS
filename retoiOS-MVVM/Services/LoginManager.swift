//
//  LoginManager.swift
//  RetoiOS
//
//  Created by Ronald Martinez on 6/18/19.
//  Copyright Â© 2019 Ronald. All rights reserved.
//

import Foundation


public class LoginManager {
    
    public func loginWithCredentials(username: String, password: String,
                                     completion: @escaping (_ success:Bool) -> Void) {
        
        self.create_token(api_key: BuildConfig.ApiKey()) { (token) in
            if !token.success {
                completion(false)
            } else {
                let urlString = "\(BuildConfig.ServerName())/authentication/token/validate_with_login?api_key=\(BuildConfig.ApiKey())"
                var headers = [String: String]()
                headers["Content-Type"] = "application/json"
                let url:NSURL = NSURL(string: urlString)!
                var request = URLRequest(url: url as URL)
                request.httpMethod = "POST"
                let params = [
                    "username" : username,
                    "password" : password, "request_token": token.request_token]
                guard let httpBody = try? JSONSerialization.data(
                    withJSONObject: params, options: []) else { return }
                request.httpBody = httpBody
                for header in headers {request.setValue(header.value, forHTTPHeaderField: header.key)}
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let e = error {
                        print("e: ", e)
                        completion(false)
                    } else {
                        let dataparsing = String(bytes: data!, encoding: .utf8)
                        print("dataparsing: ", dataparsing!)
                        let responseValidateWithLogin = try! JSONDecoder().decode(
                            ResponseValidateWithLogin.self, from: data!)
                        completion(responseValidateWithLogin.success!)
                    }
                }
                task.resume()
            }
        }
    }
    
    private func create_token(api_key:String, completion: @escaping ( _ response: ResponseToken)->Void  )  {
        let urlString = "\(BuildConfig.ServerName())/authentication/token/new?api_key=\(api_key)"
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        let url:NSURL = NSURL(string: urlString)!
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        for header in headers {request.setValue(header.value, forHTTPHeaderField: header.key)}
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print("e: ", e)
                completion(ResponseToken(success: false, expires_at: "", request_token: "") )
            } else {
                let dataparsing = String(bytes: data!, encoding: .utf8)
                print("token: ", dataparsing!)
                let responseToken = try! JSONDecoder().decode(
                    ResponseToken.self, from: data!)
                completion(responseToken)
            }
        }
        task.resume()
    }
}
