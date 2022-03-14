//
//  ContentView.swift
//  Tests Demo
//
//  Created by Steve Plavetzky on 3/14/22.
//

import SwiftUI

enum LoginResponse{
    case success
    case invalidCredentials
    
    var description: String{
        switch self {
            
        case .success:
            return "Successfully Signed in"
        case .invalidCredentials:
            return "Invalid Credentials"
        }
    }
}


struct ContentView: View {
    private let dummyDatabase = [User(username: "Steve", password: "Password")]
    @State var username = ""
    @State var password = ""
    private var validate = ValidationService()
    @State var message = ""
    @State var shouldShowAlert = false
       
    
    var body: some View {
        VStack(spacing: 10){
            TextField("Username", text: $username)
            TextField("Password", text: $password)
            Button  {
                do {
                    try validate.validateUsername(username)
                    try validate.validatePassword(password)
                    
                    validateValidUser()
                    
                } catch let e{
                    
                    let error = e as? ValidationError
                    message = error?.errorDescription ?? ""
                    shouldShowAlert.toggle()
                }
            } label: {
                Text("Validate")
            }
        }
        .padding()
        .alert("\(message)", isPresented: $shouldShowAlert){
            Button("OK", role: .cancel, action: okTapped)
        }
    }
    
    
    func okTapped(){
        
    }
    
    
    func validateValidUser(){
        if let user = dummyDatabase.first(where: { user in
            user.username == username && user.password == user.password
        }) {
            shouldShowAlert.toggle()

            message = LoginResponse.success.description + " as \(user.username)"
        } else {
            shouldShowAlert.toggle()
            message = LoginResponse.invalidCredentials.description
        }
    }
}
