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
        ContactTableView.delegate = self
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


extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit"){_, _, _ in
            let alertController = UIAlertController(title: "Update Contact", message: "Please update your contact details", preferredStyle: .alert)
            
            let save = UIAlertAction(title: "Save", style: .default) { _ in
                if let firstName = alertController.textFields?[0].text,
                   let lastName = alertController.textFields?[1].text
                {
                    let contact = Contact(firstName: firstName, lastName: lastName)
                    self.contactList[indexPath.row] = contact
                    self.ContactTableView.reloadData()
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertController.addTextField{ firstName in
                firstName.placeholder = self.contactList[indexPath.row].firstName
            }
            alertController.addTextField{ lastName in
                lastName.placeholder = self.contactList[indexPath.row].lastName
            }
            
            alertController.addAction(save)
            alertController.addAction(cancel)
            
            self.present(alertController,animated: true)
        }
        
        let delete = UIContextualAction(style: .destructive, title: "Delete"){_, _, _ in
            self.contactList.remove(at: indexPath.row)
            self.ContactTableView.reloadData()
        }
        edit.backgroundColor = UIColor.systemMint
        let swipeConfig = UISwipeActionsConfiguration(actions: [delete,edit])
        
        return swipeConfig
    }
}
