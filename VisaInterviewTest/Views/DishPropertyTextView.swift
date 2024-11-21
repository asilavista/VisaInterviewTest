//
//  DishPropertyTextView.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI

struct DishPropertyTextView<T:CustomStringConvertible>: View {
    var title: String?
    var value: T?
    var placeholder:String? = "N/A"
    var titleFont:Font = .title3
    var titleFontWeight:Font.Weight = .regular
    
    var valueFont:Font = .title3
    var valueFontWeight:Font.Weight = .semibold
    
    var separator = ": "
    var spacing:CGFloat = 8
    
    var body: some View {
        HStack(spacing: spacing) {
            if let title = title {
                Text("\(title)\(separator)")
                    .font(titleFont)
                    .fontWeight(titleFontWeight)
                Spacer()
            }
            
            let valueText = value == nil || (value as? String)?.isEmpty == true ? placeholder : value?.description
            if let valueText = valueText {
                Text(valueText)
                    .font(valueFont)
                    .fontWeight(valueFontWeight)
            }
        }
    }
}



struct DishPropertyTextView_Previews: PreviewProvider {
    static var previews: some View {
        let dish = Dish.mock[0]
        DishPropertyTextView(title: "Carbos", value: dish.carbos)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
