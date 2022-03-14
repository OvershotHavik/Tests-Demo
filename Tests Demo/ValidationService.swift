//
//  Validation.swift
//  Tests Demo
//
//  Created by Steve Plavetzky on 3/14/22.
//

import Foundation

enum ValidationError: LocalizedError{
    case invalidUsername
    case invalidPassword
    case passwordTooLong
    case passwordTooShort
    case usernameTooLong
    case usernameTooShort
    
    var errorDescription: String?{
        switch self {
        case .invalidUsername:
            return "You must enter a username."
        case .invalidPassword:
            return "You must enter a password."
        case .passwordTooLong:
            return "Your password is too long."
        case .passwordTooShort:
            return "Your password is too short."
        case .usernameTooLong:
            return "Your username is too long."
        case .usernameTooShort:
            return "Your username is too short."
        }
    }
    
}


enum LoginResponse: LocalizedError{
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

struct ValidationService {
    func validateUsername(_ username: String) throws{
        guard username != "" else {throw ValidationError.invalidUsername }
        guard username.count > 3 else {throw ValidationError.usernameTooShort }
        guard username.count < 20 else { throw ValidationError.usernameTooLong }
    }
    
    
    func validatePassword(_ password: String) throws{
        guard password != "" else {throw ValidationError.invalidPassword}
        guard password.count >= 8 else {throw ValidationError.passwordTooShort}
        guard password.count < 20 else {throw ValidationError.passwordTooLong}
    }
    
    
    func validateValidUser(username: String, password: String) throws{
        let dummyDatabase = [User(username: "Steve", password: "Password")]

        if dummyDatabase.first(where: { user in
            user.username == username && user.password == user.password
        }) != nil {
            throw LoginResponse.success
        } else {
            throw LoginResponse.invalidCredentials
        }
    }
}
