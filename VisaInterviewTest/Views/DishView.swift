//
//  DishView.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI

struct DishView: View {
    @State private var dish:Dish?
    @State private var error:Error?
    private let dataKeyName:String
    init(dataKeyName:String) {
        self.dataKeyName = dataKeyName
    }
    
    var body: some View {
        GeometryReader { geo in
            if let dish = dish {
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
            } else if let error = error {
                Text(error.localizedDescription)
            } else {
                Text("Loading your data...")
            }
        }.task {
            Task.detached(priority: .background) {
                let decryptionResult = await LocalAuthenticationHandler.shared.decryptWithBiometric(for: dataKeyName)
                
                await MainActor.run {
                    switch decryptionResult {
                    case .failure(let error):
                        self.error = error
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let dish = try decoder.decode(Dish.self, from: data)
                            self.dish = dish
                        } catch {
                            self.error = error
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
