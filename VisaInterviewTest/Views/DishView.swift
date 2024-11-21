//
//  DishView.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI

struct DishView: View {
    var dish:Dish
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    ZStack(alignment:.top) {
                        AsyncCacheImage(url: dish.image) {
                            Color.gray.opacity(0.2)
                        }
                        .scaledToFit()
                        .frame(width: geo.frame(in: .global).width)

                        Text(dish.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black, radius: 3, x: 0, y: 0)
                            .padding(.top, 8)
                    }
                    
                    VStack(spacing: 8) {
                        DishPropertyTextView(value: dish.description)
                            .padding(.vertical)
                        DishPropertyTextView(title: "Fats", value:dish.fats)
                        DishPropertyTextView(title: "Calories", value: dish.calories)
                        DishPropertyTextView(title: "Carbos", value: dish.carbos)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DishView_Previews: PreviewProvider {
    static var previews: some View {
        DishView(dish: Dish.mock[0])
    }
}
