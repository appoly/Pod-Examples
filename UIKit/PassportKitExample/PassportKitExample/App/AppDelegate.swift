//
//  AppDelegate.swift
//  PassportKitExample
//
//  Created by James Wolfe on 24/11/2020.
//



import UIKit
import PassportKit
import IQKeyboardManagerSwift



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Variables
    let passport = PassportKit(Configuration.passport, delegate: nil)
    var window: UIWindow?
    
    var initialVC: UIViewController {
        return passport.isAuthenticated() ? ViewController() : LoginViewController()
    }
    
    
    
    // MARK: - App Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        setupInitialVC()
        setupDependencies()
        setupNotifications()
        return true
    }
    
    
    
    // MARK: - Setup
    
    @objc private func setupInitialVC() {
        self.window = window == nil ? UIWindow(frame: UIScreen.main.bounds) : window!
        window!.rootViewController = initialVC
        window!.makeKeyAndVisible()
        UIView.transition(with: window!,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil
        )
    }
    
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupInitialVC), name: .loggedIn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupInitialVC), name: .loggedOut, object: nil)
    }
    
    
    private func setupDependencies() {
        IQKeyboardManager.shared.enable = true
    }

}

