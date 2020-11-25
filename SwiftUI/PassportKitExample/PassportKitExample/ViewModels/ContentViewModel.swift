//
//  ContentViewModel.swift
//  PassportKitExample
//
//  Created by James Wolfe on 25/11/2020.
//



import Foundation



class ContentViewModel {
    
    // MARK: - Variables
    
    private let authentication = Authentication.shared
    
    
    
    // MARK: - Actions
    
    public func unauthenticate() {
        authentication.unauthenticate()
    }
    
}
