//
//  LocalAuthenticationHandler.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import LocalAuthentication

class LocalAuthenticationHandler {
    func authenticate(completionSuccess: @escaping (Bool, Error?) -> ()) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                completionSuccess(success, authenticationError)
            }
        } else {
            completionSuccess(false, NSError(domain: "No biometrics found", code: -1, userInfo: nil))
        }
    }
}
