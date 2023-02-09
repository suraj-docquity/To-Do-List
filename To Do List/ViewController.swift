//
//  ViewController.swift
//  To Do List
//
//  Created by Suraj Jaiswal on 09/02/23.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var ContactTableView: UITableView!
    
    var contactList = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }


    @IBAction func AddContact(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Contact", message: "Please enter your contact details", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            if let firstName = alertController.textFields?[0].text,
               let lastName = alertController.textFields?[1].text
            {
                let contact = Contact(firstName: firstName, lastName: lastName)
                self.contactList.append(contact)
                self.ContactTableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField{ firstName in
            firstName.placeholder = "Enter your firstname"
        }
        alertController.addTextField{ lastName in
            lastName.placeholder = "Enter your lastname"
        }
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController,animated: true)
    }
}


extension ViewController {
    func configuration(){
        
        ContactTableView.dataSource = self
        ContactTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{
            return UITableViewCell()
        }
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = contactList[indexPath.row].firstName
        cell.detailTextLabel?.text = contactList[indexPath.row].lastName
        
        return cell
    }
}
