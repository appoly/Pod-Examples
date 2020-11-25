//
//  LoginViewModel.swift
//  PassportKitExample
//
//  Created by James Wolfe on 25/11/2020.
//



import Foundation
import PassportKit
import SwiftUI



public class LoginViewModel: NSObject, ObservableObject {
    
    // MARK: - Variables
    
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    @Published var isLoading: Bool = false
    @Published var email: String = "" {
        didSet {
            model.setEmail(string: email)
        }
    }
    @Published var password: String = "" {
        didSet {
            model.setPassword(string: password)
        }
    }
    
    private(set) var model: PassportViewModel!
    private let authentication = Authentication.shared
    
    
    
    // MARK: = Initializer
    
    override init() {
        super.init()
        model = PassportViewModel(delegate: self)
        authentication.delegate = self
    }
    
    
    
    // MARK: - Actions
    
    public func authenticate() {
        withAnimation { [weak self] in
            self?.isLoading = true
        }
        authentication.authenticate(with: model)
    }
    
    
    public func validateForLogin() {
        let valid = model.validateForLogin()
        withAnimation { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            self.passwordError = valid ? "" : self.passwordError
            self.emailError = valid ? "" : self.emailError
        }
    }
    
}



extension LoginViewModel: AuthenticationDelegate, PassportViewDelegate {
    
    public func success() { }
    
    
    public func failed(_ error: String) {
        let isEmailError = error.lowercased().contains("email")
        withAnimation { [weak self] in
            guard let self = self else { return }
            if(isEmailError) {
                self.emailError = error
                self.passwordError = ""
            } else {
                self.passwordError = error
                self.emailError = ""
            }
            self.isLoading = false
        }
    }
    
}
