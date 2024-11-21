//
//  NSCacheEx.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import UIKit

extension NSCache where KeyType == NSString, ObjectType == UIImage {
    subscript(_ key:String) -> UIImage? {
        object(forKey: key as NSString)
    }
    
    subscript(_ key:String, _ image:UIImage) -> Void {
        setObject(image, forKey: key as NSString)
    }
}
