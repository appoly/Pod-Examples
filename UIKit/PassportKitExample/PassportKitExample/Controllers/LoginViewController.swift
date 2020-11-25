//
//  LoginViewController.swift
//  PassportKitExample
//
//  Created by James Wolfe on 24/11/2020.
//



import UIKit
import PassportKit



class LoginViewController: StateViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    // MARK: - Actions
    
    @IBAction func loginButton_TouchUpInsde(_ sender: UIButton) {
        state = .loading
        guard viewModel.validateForLogin() else { return }
        passport.authenticate(viewModel)
    }
    
    
    @IBAction func emailTextField_EditingChanged(_ sender: UITextField) {
        state = .error(error: LoginError.none)
        viewModel.setEmail(sender)
    }
    
    
    
    @IBAction func textField_EditingDidEnd(_ sender: UITextField) {
        if(viewModel.validateForLogin()) {
            state = .loaded
        }
    }
    
    
    @IBAction func textFIed_EditingDidBegin(_ sender: UITextField) {
        state = .error(error: LoginError.none)
    }
    
    
    @IBAction func passwordTextField_EditingChanged(_ sender: UITextField) {
        state = .error(error: LoginError.none)
        viewModel.setPassword(sender)
    }
    
    
    
    // MARK: - Variables
    
    var passport: PassportKit!
    var viewModel: PassportViewModel!
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passport = PassportKit(Configuration.passport, delegate: self)
        viewModel = PassportViewModel(delegate: self)
        state = .error(error: LoginError.none)
    }
    
    
    
    // MARK: - Utilities
    
    override func update(for state: StateViewController.State) {
        super.update(for: state)
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch state {
                case .loaded:
                    self?.viewHasLoaded()
                case .loading:
                    self?.viewIsLoading()
                case .error:
                    self?.viewHasError()
            }
        }
    }
    
    
    override func show(error: Error, for time: DispatchTime = .now() + 2.0) {
        guard let error = error as? LoginError else { return }
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch error {
                case .email(let message):
                    self?.emailErrorLabel?.text = message
                    self?.emailErrorLabel?.alpha = 1
                    self?.viewHasError()
                case .password(let message):
                    self?.passwordErrorLabel?.text = message
                    self?.passwordErrorLabel?.alpha = 1
                    self?.viewHasError()
                case .none:
                    self?.passwordErrorLabel?.alpha = 0
                    self?.emailErrorLabel?.alpha = 0
            }
        }
    }
    
    
    private func viewHasLoaded() {
        loginButton.alpha = 1
        loginButton.isEnabled = true
        emailErrorLabel?.text = ""
        emailErrorLabel?.alpha = 0
        passwordErrorLabel?.text = ""
        passwordErrorLabel?.alpha = 0
    }
    
    
    private func viewIsLoading() {
        loginButton.alpha = 0.5
        loginButton.isEnabled = false
        emailErrorLabel?.text = ""
        emailErrorLabel?.alpha = 0
        passwordErrorLabel?.text = ""
        passwordErrorLabel?.alpha = 0
    }
    
    
    private func viewHasError() {
        contentView?.alpha = 1
        loginButton.alpha = 0.5
        activityIndicator?.stopAnimating()
        loginButton.isEnabled = false
    }

}



extension LoginViewController: PassportViewDelegate {
    
    func failed(_ error: String) {
        let isEmailError = error.lowercased().contains("email")
        let error = isEmailError ? LoginError.email(error: error) : LoginError.password(error: error)
        show(error: error)
    }
    
    
    func success() {
        NotificationCenter.default.post(name: .loggedIn, object: nil)
    }
    
}
