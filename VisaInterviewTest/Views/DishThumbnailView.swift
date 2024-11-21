//
//  DishThumbnailView.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI

struct DishThumbnailView: View {
    var dish:Dish
    var thumbImageSize:CGFloat = 100
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
            Text(dish.name)
                .font(.title3.italic())
                .fontWeight(.medium)
                .underline()
                .multilineTextAlignment(.leading)
            
            ZStack {
                HStack {
                    Spacer()
                    AsyncCacheImage(url: dish.thumb) {
                        Color.gray.opacity(0.2)
                    }
                    .scaledToFill()
                    .frame(width: thumbImageSize, height: thumbImageSize)
                    .cornerRadius(thumbImageSize / 2)
                    Spacer()
                }
                
                VStack(alignment:.leading, spacing: 4) {
                    DishPropertyTextView(title: "Fats", value:dish.fats)
                    DishPropertyTextView(title: "Calories", value: dish.calories)
                    DishPropertyTextView(title: "Carbos", value: dish.carbos)
                }
            }
        }
    }
}


struct DishThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        DishThumbnailView(dish: Dish.mock[0])
    }
}
