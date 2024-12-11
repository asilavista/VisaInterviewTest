//
//  LocalAuthenticationHandler.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import LocalAuthentication
import CryptoKit

class LocalAuthenticationHandler {

    static let shared = LocalAuthenticationHandler()
    private init() {}
    
    private let context = LAContext()
    
    func encryptWithBiometric<T:Codable>(object: T, for keyName:String) async -> Result<Bool, Error> {
        guard let data = try? JSONEncoder().encode(object) else {
            return .failure(NSError(domain: "Encryption", code: -1, userInfo:[NSLocalizedDescriptionKey: "failed to encode to data: \(object)"]))
        }
        
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            return .failure(error!)
        }
        
        guard let accessControl = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            .userPresence,
            nil)
        else {
            return .failure(NSError(domain: "Encryption", code: -1, userInfo: [NSLocalizedDescriptionKey: "Access control creation failed."]))
        }
        
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyName,
            kSecAttrAccessControl as String: accessControl,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(attributes as CFDictionary, nil)
        if status == errSecSuccess {
            return .success(true)
        } else {
            return .failure(NSError(domain: "Encryption", code: Int(status), userInfo: [NSLocalizedDescriptionKey: "Failed to store data in Keychain."]))
        }
    }
    
    func decryptWithBiometric(for keyName:String) async -> Result<Data, Error> {
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            let error = error ?? NSError(domain: "Decryption", code: -1, userInfo: [NSLocalizedDescriptionKey:"Failed to retrieve data"])
            return .failure(error)
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyName,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else {
            return .failure(NSError(domain: "Decryption", code: Int(status), userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve data from Keychain."]))
        }
        return .success(data)
    }
    
    func authenticate(reason:String = "We need to unlock your data.") async -> (success:Bool, error:Error?) {
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return (false, NSError(domain: "No biometrics found", code: -1, userInfo: nil))
        }
        
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                return continuation.resume(returning: (success, authenticationError))
            }
        }
    }
}
