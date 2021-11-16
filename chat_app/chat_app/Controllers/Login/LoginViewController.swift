//
//  LoginViewController.swift
//  chat_app
//
//  Created by Admin on 11/14/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(clickRegister))
        usernameTextFiled.delegate = self
        passwordTextFiled.delegate = self
        self.hideKeyBoardWhenTapAround()
    }
    
    @objc func clickRegister() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func clickLogin(_ sender: Any) {
        login()
    }
    
    func login() {
        guard let email = usernameTextFiled.text, let password = passwordTextFiled.text else { return }
        AuthManager.shared.login(email: email, password: password) { result in
            switch result {
            case .success(_):
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextFiled {
            passwordTextFiled.becomeFirstResponder()
        }
        
        if textField == passwordTextFiled {
            login()
        }
        return true
    }
}
