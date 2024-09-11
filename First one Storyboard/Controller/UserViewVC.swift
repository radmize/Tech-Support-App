//
//  UserViewVC.swift
//  Kama Diesel Support
//
//  Created by Radmir Zaripov on 05.05.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class UserViewVC: UIViewController {
    
    @IBOutlet weak var ThemeText    : UITextField!
    @IBOutlet weak var UserIDText   : UITextField!
    @IBOutlet weak var NumberText   : UITextField!
    @IBOutlet weak var MailText     : UITextField!
    @IBOutlet weak var TicketText   : UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    let db = Firestore.firestore()
    
    

    @IBAction func SendUserText(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        
        let timestamp = NSDate().timeIntervalSince1970
        db.collection("Ticket").addDocument(data: [
            "Тема"  : ThemeText.text  ?? " ",
            "ФИО"   : UserIDText.text ?? " ",
            "Номер" : NumberText.text ?? " ",
            "Почта" : MailText.text   ?? " ",
            "Текст" : TicketText.text ?? " ",
            "Статус": false                 ,
            "timestamp": timestamp
        ])
        {(error) in if let _ = error {
            print(1)
        }
        }
        
        
    }


}
