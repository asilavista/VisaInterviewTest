//
//  DishEx.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import Foundation

extension Dish {
    static var mock:[Dish] {
        [
            Dish(
                id: UUID().uuidString,
                name: "Crispy Fish Goujons",
                fats: "8 g",
                calories: "516 kcal",
                carbos: "47 g",
                description: "There’s nothing like the simple things in life - the smell of freshly cut grass, sitting outside on a nice sunny day, spending time with friends and family. Well here is a recipe that delivers simple culinary pleasures - some nice fresh fish with a crispy crust, crunchy potato wedges and some delightfully sweet sugar snap peas flavoured with cooling mint. Slip into something comfortable and relax into a delicious dinner!",
                thumb: URL(string:"https://img.hellofresh.com/f_auto,q_auto,w_300/hellofresh_s3/image/533143aaff604d567f8b4571.jpg"),
                image: URL(string:"https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")),
            
            Dish(
                id: UUID().uuidString,
                name: "Moroccan Skirt Steak",
                fats: "5 g",
                calories: "397 kcal",
                carbos: "26 g",
                description: "Close your eyes, open up your Ras El Hanout and inhale deeply. You are no longer standing in your kitchen. Around you are the sounds of a bustling market. Robed men sell ornate carpets and a camel nibbles affectionately at your ear.  OK, we’re pretty sure Paul McKenna’s job is safe for now, but get cooking this recipe and take dinnertime on a magic carpet ride to Casablanca! Our tip for this recipe is to take your meat out of the fridge at least 30 minutes before dinner which will allow you to cook it more evenly.",
                thumb: URL(string:"https://img.hellofresh.com/f_auto,q_auto,w_300/hellofresh_s3/image/53314247ff604d44808b4569.jpg"),
                image: URL(string:"https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/53314247ff604d44808b4569.jpg"))
        ]
    }
}
