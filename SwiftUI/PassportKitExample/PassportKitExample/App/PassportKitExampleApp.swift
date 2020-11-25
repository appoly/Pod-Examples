//
//  PassportKitExampleApp.swift
//  PassportKitExample
//
//  Created by James Wolfe on 25/11/2020.
//



import SwiftUI
import PassportKit
import IQKeyboardManagerSwift



@main
struct PassportKitExampleApp: App {
    
    // MARK: - Variables
    
    @ObservedObject var authentication = Authentication.shared
    
    
    
    // MARK: - Initializers
    
    init() {
        IQKeyboardManager.shared.enable = true
    }
    
    
    
    // MARK: - View
    
    var body: some Scene {
        WindowGroup {
            if(authentication.authenticated) {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
    
}
