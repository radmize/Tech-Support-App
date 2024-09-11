//
//  TechSupVC.swift
//  Kama Diesel Support
//
//  Created by Radmir Zaripov on 07.05.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
class TechSupVC: UIViewController{
    var tickets: [[String: Any]] = []
    let db = Firestore.firestore()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadTickets()
    }
    // ??
    func loadTickets(){
        let ticketsCollection = db.collection("Ticket").order(by: "timestamp", descending: true)
        ticketsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting tickets: \(error)")
            } else {
                // Clear existing tickets before populating
                self.tickets.removeAll()
                for document in querySnapshot!.documents {
                    if let ticketData = document.data() as? [String: Any] {
                        self.tickets.append(ticketData)
                    }
                }
               DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    @IBAction func BackButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    //LogOut
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
        do {
        try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            SharedData.shared.defaults.set(false, forKey: "Logged")
            SharedData.shared.logged = false
        } catch _ as NSError{
        }
    }
    //Убирает контроллер
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TicketViewController" {
            if let selectedTicket = sender as? [String: Any],
               let destVC = segue.destination as? TIcketVC {
                destVC.ticketData = selectedTicket
            }
        }
    }
}
    //Передает и обслуживает таблицы в table view
extension TechSupVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return SharedData.shared.theme.count
        return tickets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TCell", for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        let ticket = tickets[indexPath.row]
        var check: Bool = (ticket["Статус"] != nil)
//        cell.backgroundColor = SharedData.shared.colorofthecell[indexPath.row]
//        cell.textLabel?.text = SharedData.shared.theme[indexPath.row]
        if check { cell.backgroundColor = UIColor.systemGreen} else { cell.backgroundColor = UIColor.systemRed}
            cell.textLabel?.text = ticket["Тема"] as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTicket = tickets[indexPath.row]
        performSegue(withIdentifier: "TicketViewController", sender: selectedTicket)
    }
}
