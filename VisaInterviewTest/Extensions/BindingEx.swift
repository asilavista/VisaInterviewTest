//
//  BindingEx.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import Foundation
import SwiftUI
import Combine

extension Binding where Value == Bool {
    init<T>(_ optionalValue:Binding<T?>) {
        self = Self(get: {
            optionalValue.wrappedValue != nil
        }, set: { newValue in
            if !newValue {
                optionalValue.wrappedValue = nil
            }
        })
    }
}
