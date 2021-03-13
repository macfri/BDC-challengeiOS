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
    var errorMessage: Observable<String?> = Observable(nil)
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    var isUsernameTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)

    
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
        }
    }

    func credentialsInput() -> CredentialsInputStatus {
        if username.isEmpty && password.isEmpty {
            credentialsInputErrorMessage.value = "Please provide username and password."
            return .Incorrect
        }
        if username.isEmpty {
            credentialsInputErrorMessage.value = "Username field is empty."
            isUsernameTextFieldHighLighted.value = true
            return .Incorrect
        }
        if password.isEmpty {
            credentialsInputErrorMessage.value = "Password field is empty."
            isPasswordTextFieldHighLighted.value = true
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
