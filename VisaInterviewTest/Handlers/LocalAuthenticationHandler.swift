//
//  LocalAuthenticationHandler.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import LocalAuthentication

class LocalAuthenticationHandler {
    func authenticate() async -> (success:Bool, error:Error?) {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return (false, NSError(domain: "No biometrics found", code: -1, userInfo: nil))
        }
        
        let reason = "We need to unlock your data."
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                return continuation.resume(returning: (success, authenticationError))
            }
        }
    }
}
