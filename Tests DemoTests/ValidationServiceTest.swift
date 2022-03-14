//
//  ValidationServiceTest.swift
//  Tests DemoTests
//
//  Created by Steve Plavetzky on 3/14/22.
//
@testable import Tests_Demo
import XCTest



class ValidationServiceTest: XCTestCase {

    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    
    override func tearDown() {
        //not used in this project, but good to practice to revert it back
        //make sure to remove the "class" from the function name for both of these to get the correct validation
        super.tearDown()
        validation = nil
    }

    
    func test_is_valid_username() throws {
        XCTAssertNoThrow(try validation.validateUsername("Steve"))
    }
    
    
    func test_username_is_blank() throws {
        let expectedError = ValidationError.invalidUsername
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validateUsername("")){ thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    
    func test_username_is_too_short() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validateUsername("12")) { thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    
    func test_username_is_too_long() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let longUsername = "Testing Long Username Here"
        
        XCTAssertThrowsError(try validation.validateUsername(longUsername)){ thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    
    func test_password_is_valid() throws {
        XCTAssertNoThrow(try validation.validatePassword("Password"))
    }
    
    
    func test_password_is_blank() throws {
        let expectedError = ValidationError.invalidPassword
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("")){ thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_password_too_short() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("123")) {thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    
    func test_password_too_long() throws {
        let expectedError = ValidationError.passwordTooLong
        var error: ValidationError?
        let longPassword = "Testing Long Password Here"
        
        XCTAssertThrowsError(try validation.validatePassword(longPassword)) {thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    
    func test_valid_username_entered() throws {
        let expectedError = LoginResponse.success
        var error: LoginResponse?
        let username = "Steve"
        let password = "Password"
        
        XCTAssertThrowsError(try validation.validateValidUser(username: username, password: password)) {thrownError in
            error = thrownError as? LoginResponse
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.description, error?.description)
    }
    
    
    func test_invalid_username_entered() throws {
        let expectedError = LoginResponse.invalidCredentials
        var error: LoginResponse?
        let username = "test"
        let password = "Password"
        
        XCTAssertThrowsError(try validation.validateValidUser(username: username, password: password)) {thrownError in
            error = thrownError as? LoginResponse
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.description, error?.description)
    }
}
