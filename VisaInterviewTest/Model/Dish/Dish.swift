//
//  Dish.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import Foundation

struct Dish:Codable, Identifiable {
    var id, name:String
    var fats, calories, carbos, description:String?
    var thumb ,image:URL?
}
