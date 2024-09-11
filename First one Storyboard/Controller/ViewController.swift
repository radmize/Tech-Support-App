//
//  ViewController.swift
//  First one Storyboard
//
//  Created by Radmir Zaripov on 03.05.2024.
//

import UIKit
import AVFoundation
import CoreData
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
//keyboard remover
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
//new class for program wide data collection
class SharedData{
    static let shared = SharedData()
//    var colorofthecell: [UIColor] = []
//    var theme: [String] = []
//    var user: [String] = []
//    var userphone: [String] = []
//    var mail: [String] = []
//    var tickettext: [String] = []
//    var donecheck: [Bool] = []
    var logged: Bool = false
    var defaults = UserDefaults.standard
}


class ViewController: UIViewController, UITextFieldDelegate {
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //defaults.set(false, forKey: "Logged")
        SharedData.shared.logged = SharedData.shared.defaults.bool(forKey: "Logged")
    }
    @IBAction func NewTicketButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "UserViewSegue", sender: self)
    }
    @IBAction func TechSupportButtonPressed(_ sender: UIButton) {
        if SharedData.shared.logged{
            performSegue(withIdentifier: "TechSupportSegue", sender: self)
        } else {
            performSegue(withIdentifier: "LoginViewSegue", sender: self)
        }
    }
}

