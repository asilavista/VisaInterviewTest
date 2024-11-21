//
//  HomeScreenView.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        JsonLoaderView(\.dishList) { decodedDishes in
            DishesListView(dishes:decodedDishes)
        }
    }
}
