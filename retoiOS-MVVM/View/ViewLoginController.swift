//
//  ViewController.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import UIKit

class ViewLoginController: UIViewController {

    // MARK: - Stored Properties
    var loginViewModel: LoginViewModel!

    //MARK: - IBOutlets
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var loginErrorDescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtPassword.isSecureTextEntry = true
        btnLogin.layer.cornerRadius = 5
        txtUsername.delegate = self
        txtPassword.delegate = self
        let loginManager = LoginManager()
        self.loginViewModel = LoginViewModel(loginManager: loginManager)
        bindData()
    }

    func bindData() {
          loginViewModel.credentialsInputErrorMessage.bind { [weak self] in
              self?.loginErrorDescriptionLabel.isHidden = false
              self?.loginErrorDescriptionLabel.text = $0
          }
          
        loginViewModel.success.bind { [weak self] (success) in
            guard let success = success else { return }
            if success {
                  DispatchQueue.main.async {
                        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let vc = sb.instantiateViewController(
                            withIdentifier: "ViewHomeController") as! ViewHomeController
                self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

    @IBAction func btnLogin(_ sender: UIButton) {
        loginViewModel.updateCredentials(
            username: txtUsername.text!,
            password: txtPassword.text!
        )
         switch loginViewModel.credentialsInput() {
            case .Correct:
                loginViewModel.login()
            case .Incorrect:
                return
         }
    }
    
    func highlightTextField(_ textField: UITextField) {
       textField.resignFirstResponder()
       textField.layer.borderWidth = 1.0
       textField.layer.borderColor = UIColor.red.cgColor
       textField.layer.cornerRadius = 3
    }
}

extension ViewLoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtUsername.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.loginErrorDescriptionLabel.isHidden = true
        self.txtUsername.layer.borderWidth = 0
        self.txtPassword.layer.borderWidth = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
