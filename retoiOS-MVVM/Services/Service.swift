//
//  Service.swift
//  RetoiOS
//
//  Created by Ronald Martinez on 6/18/19.
//  Copyright Â© 2019 Ronald. All rights reserved.
//

import Foundation

public protocol ServiceProtocol {
    func onError()
    func onSuccess()
}

public class Service:NSObject {
    var delegate:ServiceProtocol!

    init(delegate: ServiceProtocol) {
        self.delegate = delegate
    }
    
    public func getTestCases() {
        self.delegate.onSuccess()
    }
}
