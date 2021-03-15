//
//  ViewLoginController.swift
//  retoiOS-MVVM
//
//  Created by ro martinez on 3/11/21.
//  Copyright © 2021 ro martinez. All rights reserved.
//

import UIKit

class ViewLoginController: UIViewController {

    // MARK: - Stored Properties
    private var countTexts1 = 0
    private var countTexts2 = 0
    private var loginViewModel: LoginViewModel!

    //MARK: - IBOutlets
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginErrorDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if BuildConfig.checkSession() {
            self.checkSession()
        }

        btnLogin.isEnabled = false
        btnLogin.layer.cornerRadius = 5
        
        txtUsername.delegate = self
        txtPassword.delegate = self
        txtPassword.isSecureTextEntry = true

        let loginManager = LoginManager()
        self.loginViewModel = LoginViewModel(loginManager: loginManager)
        bindData()
        
//        self.txtUsername.text = "macfri"
//        self.txtPassword.text = "r0n4ld123ZZ!!"
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LoginPSD.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }

    @objc func keyboardWillHide( notification: Notification) {
        self.view.frame.origin.y = 0 // Move view 150 points upward
    }
        
    @objc func keyboardWillShow( notification: Notification) {
        self.view.frame.origin.y = -200 // Move view 150 points upward
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver( self, selector: #selector(
            keyboardWillShow(notification:)), name:
            UIResponder.keyboardWillShowNotification, object: nil )
        
        NotificationCenter.default.addObserver(self, selector: #selector(
            keyboardWillHide(notification:)), name:
            UIResponder.keyboardWillHideNotification, object: nil);
        
        txtUsername.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
            for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
            for: .editingChanged)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - TextField Delegates
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.txtUsername {
            countTexts1 = textField.text!.count
        }
        if textField == self.txtPassword{
            countTexts2 = textField.text!.count
        }
        if ( countTexts1 > 0 && countTexts2 > 0 ) {
             btnLogin.isEnabled = true
        } else {
            loginErrorDescriptionLabel.text = ""
             btnLogin.isEnabled = false
        }
    }
    
    private func checkSession(){
        let defaults = UserDefaults.standard
        if let date2 = defaults.object(forKey: "date") as? Date {
          let timediff = Date().timeIntervalSince(date2)
            if Int(timediff) < BuildConfig.reloadLoginExpiredTime() {
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = sb.instantiateViewController(
                    withIdentifier: "ViewHomeController") as! ViewHomeController
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }

    func bindData() {
        loginViewModel.credentialsInputErrorMessage.bind { [weak self] in
            self?.loginErrorDescriptionLabel.isHidden = false
            self?.loginErrorDescriptionLabel.text = $0
            self?.btnLogin.setTitle("Log in", for: .normal)
        }
          
        loginViewModel.success.bind { [weak self] (success) in
            guard let success = success else { return }
            if success {
                  DispatchQueue.main.async {
                    
                    let defaults = UserDefaults.standard
                    let date = Date()
                    defaults.set(date, forKey: "date")
                
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
                self.btnLogin.setTitle("Loading", for: .normal)

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
