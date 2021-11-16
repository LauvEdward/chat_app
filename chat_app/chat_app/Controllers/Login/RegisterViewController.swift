//
//  RegisterViewController.swift
//  chat_app
//
//  Created by Admin on 11/15/21.
//

import UIKit
import FirebaseAuth
class RegisterViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var genderViewPicker: UIPickerView!
    @IBOutlet weak var avatarImageView: UIImageView!
    let dataGender: [String] = ["Man", "Women", "Orther"]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        self.title = "Register account"
        [nameTextField, userNameTextField, passwordTextField, rePasswordTextField].forEach {
            $0?.delegate = self
        }
        genderViewPicker.dataSource = self
        genderViewPicker.delegate = self
        genderViewPicker.backgroundColor = .white
        self.hideKeyBoardWhenTapAround()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height / 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(accessPhoto))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
    }
    
    @IBAction func registerAccount(_ sender: Any) {
        guard (userNameTextField.text != nil ||
                passwordTextField.text != nil ||
                nameTextField.text != nil ||
                rePasswordTextField.text == passwordTextField.text) else {
            error()
            return
        }
        guard let email = userNameTextField.text, let password = passwordTextField.text else { return }
        AuthManager.shared.signUp(email: email, password: password) { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let isLogin):
                if isLogin {
                    strongSelf.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                strongSelf.alertError(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func alertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func error() {
        let alert = UIAlertController(title: "Error", message: "Please fill your information", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            userNameTextField.becomeFirstResponder()
        case userNameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            rePasswordTextField.becomeFirstResponder()
        case rePasswordTextField:
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom)
            scrollView.setContentOffset(bottomOffset, animated: true)
        default:
            self.hideKeyBoardWhenTapAround()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.scrollView.contentOffset.y = textField.center.y
        }, completion: nil)
    }
}

extension RegisterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataGender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataGender[row]
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func accessPhoto() {
        let alert = UIAlertController(title: "Profile", message: "Access photo for your profile", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in self?.takePhoto()}))
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { [weak self] _ in self?.selectPhoto()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func takePhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        self.present(vc, animated: true, completion: nil)
    }
    
    func selectPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectPhoto = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.avatarImageView.image = selectPhoto
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
}
