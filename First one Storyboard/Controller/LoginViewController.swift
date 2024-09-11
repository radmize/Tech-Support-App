//
//  LoginViewController.swift
//  Kama Diesel Support
//
//  Created by Radmir Zaripov on 05.06.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet var LoginTF: UITextField!
    @IBOutlet var PasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        if let login = LoginTF.text ,let password = PasswordTF.text {
            Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "TechSupportSegue", sender: self)
                    SharedData.shared.defaults.set(true, forKey: "Logged")
                    SharedData.shared.logged = true
                }
            }
        }
    }
}
