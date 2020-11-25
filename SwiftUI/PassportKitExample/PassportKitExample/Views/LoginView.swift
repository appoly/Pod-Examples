//
//  LoginView.swift
//  PassportKitExample
//
//  Created by James Wolfe on 25/11/2020.
//



import SwiftUI
import PassportKit



struct LoginView: View {
    
    // MARK: - Variables
    
    @ObservedObject var viewModel = LoginViewModel()
    
    
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            if(viewModel.isLoading) {
                ActivityIndicatorView()
                    .transition(.opacity)
                    .animation(.easeInOut)
            } else {
                LoginFormView(viewModel: viewModel)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
        })
        .padding(.all, 20)
    }
    
}



struct LoginFormView: View {
    
    // MARK: - Variables
    
    @ObservedObject var viewModel: LoginViewModel
    
    
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            Spacer()
            EmailView(viewModel: viewModel)
            PasswordView(viewModel: viewModel)
            Button("Login".localized) {
                self.viewModel.authenticate()
            }
            .font(.system(size: 16, weight: .semibold))
            .frame(width: UIScreen.main.bounds.width - 40, height: 40, alignment: .center)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        })
    }
    
}



struct ActivityIndicatorView: View {
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            Spacer()
        })
    }
    
}



struct EmailView: View {
    
    // MARK: - Variables
    
    @ObservedObject var viewModel: LoginViewModel
    
    
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text("Email".localized)
                .frame(height: 20)
                .font(.system(size: 16, weight: .thin))
            VStack(alignment: .leading, spacing: 5, content: {
                TextInput(onEditingDidBegin: {
                    self.viewModel.email = $0 ?? ""
                    self.viewModel.emailError = ""
                }, onEditingChanged: {
                    self.viewModel.email = $0 ?? ""
                    self.viewModel.emailError = ""
                }, onEditingDidEnd: {
                    self.viewModel.email = $0 ?? ""
                    self.viewModel.validateForLogin()
                }, secure: false, placeholder: "Email".localized, contentType: .emailAddress, text: viewModel.email)
                    .frame(height: 34)
                    .font(.system(size: 16))
                    .padding(.all, 8)
                    .background(Color.textFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text(viewModel.emailError)
                    .frame(height: 15)
                    .font(.system(size: 12))
                    .foregroundColor(.errorColor)
            })
        })
    }
    
}



struct PasswordView: View {
    
    // MARK: - Variables
    
    @ObservedObject var viewModel: LoginViewModel
    
    
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text("Password".localized)
                .frame(height: 20)
                .font(.system(size: 16, weight: .thin))
            VStack(alignment: .leading, spacing: 5, content: {
                TextInput(onEditingDidBegin: {
                    self.viewModel.password = $0 ?? ""
                    self.viewModel.passwordError = ""
                }, onEditingChanged: {
                    self.viewModel.password = $0 ?? ""
                    self.viewModel.passwordError = ""
                }, onEditingDidEnd: {
                    self.viewModel.password = $0 ?? ""
                    self.viewModel.validateForLogin()
                }, secure: true, placeholder: "Password".localized, contentType: .password, text: viewModel.password)
                    .frame(height: 34)
                    .font(.system(size: 16))
                    .padding(.all, 8)
                    .background(Color.textFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text(viewModel.passwordError)
                    .frame(height: 15)
                    .font(Font.system(size: 12))
                    .foregroundColor(.errorColor)
            })
        })
    }
}



struct LoginView_Previews: PreviewProvider {
    
    // MARK: - View
    
    static var previews: some View {
        LoginView()
    }
    
}
