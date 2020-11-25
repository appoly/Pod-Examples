//
//  UITextField+UIViewRepresentable.swift
//  PassportKitExample
//
//  Created by James Wolfe on 25/11/2020.
//



import Foundation
import SwiftUI



struct TextInput: UIViewRepresentable {
    
    // MARK: - Variables
    typealias UIViewType = UITextInput
    let onEditingDidBegin: ((String?) -> Void)?
    let onEditingChanged: ((String?) -> Void)?
    let onEditingDidEnd: ((String?) -> Void)?
    let secure: Bool
    let placeholder: String
    let contentType: UITextContentType
    let text: String
    
    
    
    
    // MARK: - View Lifecycle
    
    func makeUIView(context: Context) -> UITextInput {
        let field = UITextInput(frame: .zero, editingDidBegin: onEditingDidBegin, editingChanged: onEditingChanged, editingDidEnd: onEditingDidEnd)
        field.isSecureTextEntry = secure
        field.placeholder = placeholder
        field.textContentType = contentType
        field.autocapitalizationType = .none
        field.keyboardType = contentType == .emailAddress ? .emailAddress : .default
        field.text = text
        return field
    }
    
    
    func updateUIView(_ uiView: UITextInput, context: Context) {
    }
}



class UITextInput: UITextField {
    
    // MARK: - Variables
    
    let onEditingDidBegin: ((String?) -> Void)?
    let onEditingChanged: ((String?) -> Void)?
    let onEditingDidEnd: ((String?) -> Void)?
    
    
    
    // MARK: - Initializers
    
    init(frame: CGRect, editingDidBegin: ((String?) -> Void)? = nil, editingChanged: ((String?) -> Void)? = nil, editingDidEnd: ((String?) -> Void)? = nil) {
        onEditingDidBegin = editingDidBegin
        onEditingChanged = editingChanged
        onEditingDidEnd = editingDidEnd
        
        super.init(frame: frame)
        
        addTarget(self, action: #selector(self.editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(self.editingDidEnd), for: .editingDidEnd)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Actions
    
    @objc private func editingDidBegin() {
        onEditingDidBegin?(text)
    }
    
    
    @objc private func editingChanged() {
        onEditingChanged?(text)
    }
    
    
    @objc private func editingDidEnd() {
        onEditingDidEnd?(text)
    }
    
}
