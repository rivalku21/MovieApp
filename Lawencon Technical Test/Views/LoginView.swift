//
//  LoginView.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 22/02/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray.opacity(0.3))
                
                VStack(alignment: .leading, spacing: 40) {
                    VStack(alignment: .leading) {
                        Text("Welcome!")
                            .font(.title)
                        
                        Text("Sign in to continue")
                    }
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        saveCredentials()
                    }) {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
        .padding()
    }
    
    func saveCredentials() {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        
        isLoggedIn = true
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
