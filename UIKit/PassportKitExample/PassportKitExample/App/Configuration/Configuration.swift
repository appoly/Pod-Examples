//
//  Configuration.swift
//  PassportKitExample
//
//  Created by James Wolfe on 24/11/2020.
//



import Foundation
import Keys
import PassportKit



class Configuration {
    
    static let keychainID = Bundle.main.object(forInfoDictionaryKey: "KEYCHAIN_ID") as! String
    static let baseURL = URL(string: Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String)!
    static let secret = PassportKitExampleKeys().secret
    static let clientID = PassportKitExampleKeys().clientID
    
    static let passport = PassportConfiguration(baseURL: Configuration.baseURL, clientID: Configuration.clientID, clientSecret: Configuration.secret, keychainID: Configuration.keychainID)
    
}


