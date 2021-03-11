//
//  ThreeDSTestCaseApi.swift
//  3DSecure
//
//  Created by Ronald Martinez on 6/18/19.
//  Copyright Â© 2019 Ronald. All rights reserved.
//

import Foundation

public protocol ThreeDSTestCaseMessageProtocol {
    func onTestCasesError()
//    func onTestCasesSuccess(tcMessage: TcMessage)
    func onTestCasesDeleteError()
    func onTestCasesDeleteSuccess()
}

public class Service:NSObject {
    
    var delegate:ThreeDSTestCaseMessageProtocol!
    
    init(delegate: ThreeDSTestCaseMessageProtocol) {
        self.delegate = delegate
    }
    
    public func getTestCases() {
//        let urlString = "\(ReferenceAppConfig.getTestsEndpoint())\(ReferenceAppConfig.apiKey())"
        let urlString = ""
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        let url:NSURL = NSURL(string: urlString)!
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        for header in headers {request.setValue(header.value, forHTTPHeaderField: header.key)}
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print("getTestCases.e: \(e)")
                self.delegate.onTestCasesError()
            } else {
                if let httpStatus = response as? HTTPURLResponse{
                    
                    if (httpStatus.statusCode  == 429 ){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            print("wait many connections: 429")
                            self.getTestCases()
                        }
                    }
                    
                    if httpStatus.statusCode == 200 {
                        guard let data = data else { return }
                        do {
                            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                            print("getTestCases: \(String(describing: responseJSON ?? "")) ")
                          //  let tcMessage = try JSONDecoder().decode(TcMessage.self, from: data)
                            
                            //                            print("tcMessage.count: ", tcMessage)
                            
                          //  self.delegate.onTestCasesSuccess(tcMessage: tcMessage)
                        } catch let ex {
                            self.delegate.onTestCasesError()
                            print("getTestCases.e: ", ex)
                        }
                    } else {
                        self.delegate.onTestCasesError()
                        print("getTestCases.e")
                    }
                }
            }
        }
        task.resume()
    }
    
//    public func deleteTestCases() {
//        let urlString = "\(ReferenceAppConfig.deleteTestsEndpoint())\(ReferenceAppConfig.apiKey())"
//        var headers = [String: String]()
//        headers["Content-Type"] = "application/json"
//        headers["method"] = "DELETE"
//        let url:NSURL = NSURL(string: urlString)!
//        var request = URLRequest(url: url as URL)
//        request.httpMethod = "DELETE"
//        for header in headers {request.setValue(header.value, forHTTPHeaderField: header.key)}
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let e = error {
//                print("getTestCases.e: \(e)")
//                self.delegate.onTestCasesDeleteError()
//            } else {
//                if let httpStatus = response as? HTTPURLResponse{
//                    if httpStatus.statusCode == 200 {
//                        guard let data = data else { return }
//                        do {
//                            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                            print("getTestCasesDelete: \(String(describing: responseJSON)) ")
//                            self.delegate.onTestCasesDeleteSuccess()
//                        } catch let ex {
//                            self.delegate.onTestCasesDeleteError()
//                            print("getTestCases.e: ", ex)
//                        }
//                    } else {
//                        self.delegate.onTestCasesDeleteError()
//                        print("getTestCases.e")
//                    }
//                }
//            }
//        }
//        task.resume()
//    }
    
}
