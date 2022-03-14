//
//  ContentView.swift
//  Tests Demo
//
//  Created by Steve Plavetzky on 3/14/22.
//

import SwiftUI


struct ContentView: View {
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
                    
                    try validate.validateValidUser(username: username, password: password)
                    
                } catch let e{
                    if let error = e as? ValidationError{
                        message = error.errorDescription ?? ""
                        shouldShowAlert.toggle()
                    }
                    if let error = e as? LoginResponse{
                        message = error.description
                        shouldShowAlert.toggle()
                    }
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
}
