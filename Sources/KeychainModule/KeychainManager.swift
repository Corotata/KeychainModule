// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// Keychain 管理器，用于在 Keychain 中存储和检索各种数据类型。
public class KeychainManager {
    
    /// 将数据存储到 Keychain。
    ///
    /// - Parameters:
    ///   - value: 要存储的数据。
    ///   - forKey: 存储的键。
    /// - Returns: 存储操作是否成功。
    public static func saveValueToKeychain<T: Codable>(_ value: T, forKey key: String) -> Bool {
        do {
            let data = try JSONEncoder().encode(value)
            return saveDataToKeychain(data: data, forKey: key)
        } catch {
            print("Failed to encode value: \(error)")
            return false
        }
    }
    
    /// 从 Keychain 中检索数据。
    ///
    /// - Parameter key: 要检索的键。
    /// - Returns: 检索到的数据，如果失败则为 nil。
    public static func loadValueFromKeychain<T: Codable>(forKey key: String) -> T? {
        guard let data = loadDataFromKeychain(forKey: key) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Failed to decode value: \(error)")
            return nil
        }
    }
    
    private static func saveDataToKeychain(data: Data, forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // 删除现有数据
        SecItemDelete(query as CFDictionary)
        
        // 添加新数据
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    private static func loadDataFromKeychain(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            return result as? Data
        } else {
            return nil
        }
    }
}

