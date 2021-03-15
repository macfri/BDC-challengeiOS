//
//  LoginViewModel.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import Foundation
import UIKit


class LoginViewModel  {
    
    // MARK: - Stored Properties
    private let loginManager: LoginManager    
    private var credentials = Credentials() {
        didSet {
            username = credentials.username
            password = credentials.password
        }
    }

    private var username = ""
    private var password = ""

    var success: Observable<Bool?> = Observable(false)
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    
    init(loginManager: LoginManager) {
        self.loginManager = loginManager
    }
    
    func updateCredentials(username: String, password: String) {
        credentials.username = username
        credentials.password = password
    }

    func login() {
        self.loginManager.loginWithCredentials(
        username: username, password: password) { [weak self] (success) in
            self?.success.value = success
            DispatchQueue.main.async {
                self?.credentialsInputErrorMessage.value = "Invalid username or password."
            }
        }
    }

    func credentialsInput() -> CredentialsInputStatus {
        if username.isEmpty && password.isEmpty {
            credentialsInputErrorMessage.value = "Please provide username and password."
            return .Incorrect
        }
        if username.isEmpty {
            credentialsInputErrorMessage.value = "Username field is empty."
            return .Incorrect
        }
        if password.isEmpty {
            credentialsInputErrorMessage.value = "Password field is empty."
            return .Incorrect
        }
        return .Correct
    }
}

extension LoginViewModel {
    enum CredentialsInputStatus {
        case Correct
        case Incorrect
    }
}
