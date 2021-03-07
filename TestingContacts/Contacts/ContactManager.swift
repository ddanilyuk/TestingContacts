////
////  ContactManager.swift
////  TestingContacts
////
////  Created by Denys Danyliuk on 23.11.2020.
////
//
//import UIKit
//import Contacts
//
//class ContactManager {
//    
//    static let shared = ContactManager()
//    
//    private(set) var contacts = [Contact]()
//    
//    private let contactsStore = CNContactStore()
//    
//    private init() { }
//    
//    public func getContactsFromServer(completion: ((Result<[Contact], Error>) -> Void)? = nil) {
//        getCNContacts { result in
//            
//            // Receive contacts from server
//            // Call completion
//        }
//    }
//    
//    public func requestAccess(requestGranted: @escaping (Result<Bool, Error>) -> Void) {
//        contactsStore.requestAccess(for: .contacts) { grandted, error in
//            if let error = error {
//                requestGranted(.failure(error))
//            } else {
//                requestGranted(.success(grandted))
//            }
//        }
//    }
//
//    public func authorizationStatus(requestStatus: @escaping (CNAuthorizationStatus) -> Void) {
//        requestStatus(CNContactStore.authorizationStatus(for: .contacts))
//    }
//    
//    private func getCNContacts(completion: ((Result<[CNContact], Error>) -> Void)? = nil) {
//        
//        var contactsArray = [CNContact]()
//        
//        
//        requestAccess { requestResult in
//            switch requestResult {
//            case .success(let isHaveAccess):
//                
//                guard isHaveAccess else {
//                    return
//                }
//                
//                let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
//                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
//                
//                do {
//                    
//                    try self?.contactsStore.enumerateContacts(with: fetchRequest) { (contact, _) in
//                        if let validatedContact = self?.validate(contact: contact) {
//                            contactsArray.append(validatedContact)
//                        }
//                    }
//                    completion?(.success(contactsArray))
//                    
//                } catch let error {
//                    completion?(.failure(error))
//                }
//            case .failure(let error):
//                completion?(.failure(error))
//            }
//            
//        }
//        
//        contactsStore.requestAccess(for: .contacts) { [weak self] isHaveAccess, error in
//            
//            if let error = error {
//                completion?(.failure(error))
//                return
//            }
//            
//            guard isHaveAccess else {
//                return
//            }
//            
//            let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
//            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
//            
//            do {
//                
//                try self?.contactsStore.enumerateContacts(with: fetchRequest) { (contact, _) in
//                    if let validatedContact = self?.validate(contact: contact) {
//                        contactsArray.append(validatedContact)
//                    }
//                }
//                completion?(.success(contactsArray))
//                
//            } catch let error {
//                completion?(.failure(error))
//            }
//        }
//    }
//    
//    private func validate(contact: CNContact) -> CNContact? {
//        if !contact.givenName.isEmpty, !contact.phoneNumbers.isEmpty {
//            return contact
//        } else {
//            return nil
//        }
//    }
//}
//
//
//struct Contact {
//    
//    var user: UserContact?
//    var emergency: Bool?
//    var groups: [UUID]?
//    var createdAt: String?
//    var updatedAt: String?
//}
//
//
//extension Contact {
//    
//    struct UserContact {
//        
//        var id: UUID?
//        var userName: String?
//        var photo: String?
//        var phone: String?
//        var battery: Int?
//    }
//}
