//
//  LoginError.swift
//  PassportKitExample
//
//  Created by James Wolfe on 25/11/2020.
//



import Foundation



enum LoginError: Error {
    
    case none
    case email(error: String)
    case password(error: String)
    
}
