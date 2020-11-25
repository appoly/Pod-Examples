//
//  ContentView.swift
//  PassportKitExample
//
//  Created by James Wolfe on 25/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Variables
    
    let viewModel = ContentViewModel()
    

    
    // MARK: - View
    
    var body: some View {
        VStack {
            Spacer()
            Button("Logout".localized) {
                self.viewModel.unauthenticate()
            }
            .font(.system(size: 16, weight: .semibold))
            .frame(width: UIScreen.main.bounds.width - 40, height: 40, alignment: .center)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            Spacer()
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
