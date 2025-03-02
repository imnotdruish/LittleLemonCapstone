//
//  ViewModel.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 3/1/25.
//

import Foundation
import Combine

public let kOrderStatuses = "order statuses key"
public let kPasswordChanges = "password changes key"
public let kSpecialOffers = "special offers key"
public let kNewsletter = "news letter key"

public let kFirstName = "first name key"
public let kLastName = "last name key"
public let kEmail = "e-mail key"
public let kIsLoggedIn = "kIsLoggedIn"
public let kPhoneNumber = "phone number key"

class ViewModel: ObservableObject {
    
    @Published var orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
    @Published var passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
    @Published var specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
    @Published var newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    
    @Published var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @Published var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @Published var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @Published var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    
    @Published var errorShown = false
    @Published var error = ""
    
    @Published var searchText = ""
    
    func validateProfileInput(firstName: String, lastName: String, email: String, phoneNumber: String) -> Bool {
        
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
                
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            error = "All fields are required"
            errorShown = true
            return false
        }
        
        guard emailPredicate.evaluate(with: email) else {
            error = "Invalid email address"
            errorShown = true
            return false
        }
        
        errorShown = false
        error = ""
        return true
    }
}
