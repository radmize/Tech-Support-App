//
//  TIcketVC.swift
//  Kama Diesel Support
//
//  Created by Radmir Zaripov on 08.05.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
class TIcketVC: UIViewController {
    @IBOutlet weak var TThemeLabel: UILabel!
    @IBOutlet weak var TNumber: UILabel!
    @IBOutlet weak var TNameLabel: UILabel!
    @IBOutlet weak var TMailLabel: UILabel!
    @IBOutlet weak var TTextLabel: UILabel!
    var number: Int?
    var ticketData: [String: Any] = [:]
    let db = Firestore.firestore()
    //Shows user all what was
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theme = ticketData["Тема"] as? String {
                    TThemeLabel.text = theme
                }
                if let userphone = ticketData["Номер"] as? String {
                    TNumber.text = userphone
                }
                if let username = ticketData["ФИО"] as? String {
                    TNameLabel.text = username
                }
                if let email = ticketData["Почта"] as? String {
                    TMailLabel.text = email
                }
                if let ticketText = ticketData["Текст"] as? String {
                    TTextLabel.text = ticketText
                }
    }
    //Exits controller
    @IBAction func ExitBP(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //Exits controller, sets completion to true
    @IBAction func DoneButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        ticketData.updateValue(true, forKey: "Статус")
        
    }
}
