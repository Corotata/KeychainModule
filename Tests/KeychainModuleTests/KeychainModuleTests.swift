import XCTest
@testable import KeychainModule

final class KeychainModuleTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
        let key = "AppName"
        
        let appName = "KeychainModule App"
        
        if KeychainManager.saveValueToKeychain(appName, forKey: key) {
            print("Save Success")
        }else {
            print("Save Error")
        }
        
        XCTAssertEqual(KeychainManager.loadValueFromKeychain(forKey: key), appName, "Can not to load Keychain")

        
        
    }
}
