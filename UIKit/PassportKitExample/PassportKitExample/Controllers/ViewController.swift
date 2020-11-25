//
//  ViewController.swift
//  PassportKitExample
//
//  Created by James Wolfe on 24/11/2020.
//



import UIKit
import PassportKit



class ViewController: UIViewController {
    
    // MARK: - Actions
    
    @IBAction func logoutButton_TouchUpInside(_ sender: UIButton) {
        logout()
    }
    
    
    
    // MARK: - Variables
    
    var passport: PassportKit!
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passport = PassportKit(Configuration.passport, delegate: nil)
    }
    
    
    
    // MARK: - Utilities
    
    private func logout() {
        passport.unauthenticate()
        NotificationCenter.default.post(name: .loggedOut, object: nil)
    }

}
