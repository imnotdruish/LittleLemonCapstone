//
//  MenuItemListing.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct MenuItemListing: View {
    
    let dish: Dish
    
    var body: some View {
        HStack {
            VStack {
                Text(dish.title ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.cardTitle())
                    .foregroundStyle(Color.black)
                Spacer()
                Text(dish.itemDescription ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.paragraphText())
                    .foregroundStyle(Color.llGreen)
                Spacer()
                Text("$ \(dish.price ?? "")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.highlightText())
                    .foregroundStyle(Color.llGreen)
                Spacer()
            }
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image("food-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(maxWidth: 90, maxHeight: 90)
            .clipShape(Rectangle())
        }
        .padding(.vertical)
        .frame(maxHeight: 150)
    }
}

#Preview {
    MenuItemListing(dish: PersistenceController.sampleDish())
}
