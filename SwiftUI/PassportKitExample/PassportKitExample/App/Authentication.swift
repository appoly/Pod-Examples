//
//  Authentication.swift
//  PassportKitExample
//
//  Created by James Wolfe on 25/11/2020.
//



import Foundation
import PassportKit
import SwiftUI



public protocol AuthenticationDelegate {
    
    func failed(_ error: String)
    
}



public class Authentication: NSObject, ObservableObject {
    
    // MARK: - Variables
    
    @Published public var authenticated: Bool!
    
    private static var authentication: Authentication?
    private var passport: PassportKit!
    public var delegate: AuthenticationDelegate?
    public class var shared: Authentication {
        get {
            authentication = authentication == nil ? Authentication() : authentication
            return authentication!
        }
        
    }

    
    
    // MARK: - Initializers
    
    public override init() {
        super.init()
        self.passport = PassportKit(Configuration.passport, delegate: self)
        self.authenticated = passport.isAuthenticated()
    }
    
    
    
    // MARK: - Actions
    
    public func authenticate(with model: PassportViewModel) {
        passport.authenticate(model)
    }
    
    
    public func unauthenticate() {
        passport.unauthenticate()
        authenticated = passport.isAuthenticated()
    }
    
}



extension Authentication: PassportViewDelegate {
    
    public func failed(_ error: String) {
        delegate?.failed(error)
    }
    
    
    public func success() {
        withAnimation { [weak self] in
            self?.authenticated = passport.isAuthenticated()
        }
    }
    
}
