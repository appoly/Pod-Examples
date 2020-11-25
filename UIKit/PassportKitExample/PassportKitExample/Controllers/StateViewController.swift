//
//  StateViewController.swift
//  PassportKitExample
//
//  Created by James Wolfe on 24/11/2020.
//



import Foundation
import UIKit



class StateViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var errorLabel: UILabel?
    @IBOutlet weak var contentView: UIView?
    
    
    
    // MARK: - Variables
    
    public enum State {
        case loading
        case loaded
        case error(error: Error)
    }
    
    var state: State = .loaded {
        didSet {
            update(for: state)
        }
    }
    
    
    
    // MARK: - MARK: - Utilities
    
    internal func update(for state: State) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch state {
                case .loaded:
                    self?.contentView?.alpha = 1
                    self?.errorLabel?.text = ""
                    self?.errorLabel?.alpha = 0
                    self?.activityIndicator?.stopAnimating()
                case .loading:
                    self?.contentView?.alpha = 0
                    self?.errorLabel?.text = ""
                    self?.errorLabel?.alpha = 0
                    self?.activityIndicator?.startAnimating()
                case .error(let string):
                    self?.show(error: string, for: .now() + 2.0)
            }
        }
    }
    
    
    internal func show(error: Error, for time: DispatchTime = .now() + 2.0) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.contentView?.alpha = 0
            self?.errorLabel?.text = error.localizedDescription
            self?.errorLabel?.alpha = 1
            self?.activityIndicator?.stopAnimating()
            DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
                self?.state = .loaded
            }
        }
    }
    
}
