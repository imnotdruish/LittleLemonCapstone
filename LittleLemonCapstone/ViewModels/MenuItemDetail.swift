//
//  MenuItemDetail.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct MenuItemDetail: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dish: Dish
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image("food-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .clipShape(Rectangle())
                .frame(minHeight: 150)
                .shadow(color: Color.llGray, radius: 4, x: 0, y: 5)
                
                Spacer(minLength: 50)

                VStack(alignment: .leading){
                    HStack(alignment: .bottom) {
                        Text(dish.title ?? "")
                            .font(.subTitleFont())
                            .foregroundStyle(colorScheme == .light ? Color.llGreen : Color.llYellow)
                        Spacer()
                        Text("Price:")
                            .font(.cardTitle())
                            .foregroundStyle(colorScheme == .light ? Color.llGreen : Color.llYellow)
                        Text("$ " + (dish.price ?? ""))
                            .font(.cardTitle())
                            .foregroundStyle(colorScheme == .light ? Color.llGreen : Color.llYellow)
                    }
                    
                    Spacer(minLength: 30)
                    Text("Description:")
                        .font(.sectionTitle())
                        .foregroundStyle(colorScheme == .light ? Color.llGreen : Color.llYellow)
                        .padding(.bottom)
                    Text(dish.itemDescription ?? "")
                        .font(.paragraphText())
                        .foregroundStyle(colorScheme == .light ? Color.llGreen : Color.llYellow)
                    
                    Spacer(minLength: 30)
                }
                .padding(.horizontal)
            }
        }
        .background(colorScheme == .light ? Color.llWhite : Color.llGreen)
    }
}

#Preview {
    MenuItemDetail(dish: PersistenceController.sampleDish())
}
