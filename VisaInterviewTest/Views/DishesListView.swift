//
//  DishesListView.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI
import Combine

struct DishesListView<T:Codable>: View {
    @EnvironmentObject private var vm:JsonLoaderViewModel<T>
    @State private var selectedDish:Dish?
    @State private var authError:Error?
    private var localAuth = LocalAuthenticationHandler()
    
    private var dishes:T
    init(dishes:T) {
        self.dishes = dishes
    }
    
    var body: some View {
        if let dishes = dishes as? [Dish] {
            List(dishes) { dish in
                DishThumbnailView(dish: dish)
                    .padding(.vertical, 12)
                    .onTapGesture {
                        didSelect(dish: dish)
                    }
            }
            .alert(isPresented: Binding($authError)) {
                Alert(title: Text("Authentication Error"), message: authError != nil ? Text(authError!.localizedDescription) : nil, dismissButton: .default(Text("Got it!")))
            }
            .popover(item: $selectedDish) { dish in
                DishView(dish: dish)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Dishes List")
        } else {
            Text("Unsupported model type")
        }
    }
    
    private func didSelect(dish:Dish) {
        Task.detached {
            let authenticationResult = await localAuth.authenticate()
            await MainActor.run {
                if let error = authenticationResult.error {
                    self.authError = error
                    return
                }
                
                self.selectedDish = dish
            }
        }
    }
}

struct DishesListView_Previews: PreviewProvider {
    static var previews: some View {
        DishesListView(dishes: Dish.mock)
    }
}
