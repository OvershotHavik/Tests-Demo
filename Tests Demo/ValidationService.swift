//
//  Validation.swift
//  Tests Demo
//
//  Created by Steve Plavetzky on 3/14/22.
//

import Foundation

enum ValidationError: LocalizedError{
    case invalidValue
    case passwordTooLong
    case passwordTooShort
    case usernameTooLong
    case usernameTooShort
    
    var errorDescription: String?{
        switch self {
        case .invalidValue:
            return "You have entered an invalid value."
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


struct ValidationService {
    func validateUsername(_ username: String) throws{
        guard username != "" else {throw ValidationError.invalidValue }
        guard username.count > 3 else {throw ValidationError.usernameTooShort }
        guard username.count < 20 else { throw ValidationError.usernameTooLong }
    }
    
    
    func validatePassword(_ password: String) throws{
        guard password != "" else {throw ValidationError.invalidValue}
        guard password.count >= 8 else {throw ValidationError.passwordTooShort}
        guard password.count < 20 else {throw ValidationError.passwordTooLong}
    }
}
