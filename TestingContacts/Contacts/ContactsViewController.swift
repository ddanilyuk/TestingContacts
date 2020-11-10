//
//  ContactsViewController.swift
//  TestingContacts
//
//  Created by Денис Данилюк on 06.11.2020.
//

import UIKit
import Contacts

final class ContactsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private let cellID = "cellID"
    
    // MARK: - Public Properties
    
    var contactsArray = [CNContact]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getContacts()
        NotificationCenter.default.addObserver(self, selector:#selector(reloadAfterOpenApp), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
    }
    
    @objc func reloadAfterOpenApp() {
        getContacts()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Public Actions
    
    private func getContacts() {
        contactsArray = []
        let contactsStore = CNContactStore()
        
        contactsStore.requestAccess(for: .contacts) { (isHaveAccess, error) in
            if error != nil {
                self.presentGoToSettingsAlert()
                return
            }
            if isHaveAccess {
                let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                
                do {
                    try contactsStore.enumerateContacts(with: fetchRequest) { (contact, _) in
                        self.contactsArray.append(contact)
                    }
                    self.tableView.reloadData()
                } catch let error {
                    print("Fetching contacts failed with error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func presentGoToSettingsAlert() {
        let alertController = UIAlertController(title: "No contacts access", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        DispatchQueue.main.async{
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


// MARK: - UITableViewDelegate

extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactsArray.count
    }
}


// MARK: - UITableViewDataSource

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        let contact = contactsArray[indexPath.row]
        
        cell.textLabel?.text = contact.givenName
        cell.detailTextLabel?.text = contact.phoneNumbers.first?.value.stringValue
        
        return cell
    }
}
