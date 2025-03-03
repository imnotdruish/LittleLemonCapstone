//
//  OrderView.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct OrderView: View {
    
    @State var isStartersShown = true
    @State var isMainsShown = true
    @State var isDessertsShown = true
    @State var isDrinksShown = true
    @State var searchText = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.llGreen)
                .frame(maxHeight: 60)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search Menu", text: $searchText)
                    .font(.cardTitle())
            }
            .padding(10)
            .frame(maxWidth: 400, maxHeight: 40)
            .background(Color.llWhite)
            .cornerRadius(20)
            .padding(.horizontal)
        }
        .offset(y: -40)
        Text("ORDERS FOR DELIVERY!")
            .font(.sectionTitle())
            .offset(y: -20)
        HStack {
            Toggle("Starters", isOn: $isStartersShown)
                .toggleStyle(ButtonToggleStyle())
                .tint(Color.llSalmon)
                .font(.cardTitle())
            Toggle("Mains", isOn: $isMainsShown)
                .toggleStyle(ButtonToggleStyle())
                .tint(Color.llSalmon)
                .font(.cardTitle())
            Toggle("Desserts", isOn: $isDessertsShown)
                .toggleStyle(ButtonToggleStyle())
                .tint(Color.llSalmon)
                .font(.cardTitle())
            Toggle("Drinks", isOn: $isDrinksShown)
                .toggleStyle(ButtonToggleStyle())
                .tint(Color.llSalmon)
                .font(.cardTitle())
        }
        .padding(.horizontal, 10)
        .frame(maxHeight: 30)
        FetchedObjects(predicate: buildPredicate(),
                       sortDescriptors: buildSortDescriptors()) {
            (dishes: [Dish]) in
            List(dishes) { dish in
                NavigationLink(destination: MenuItemDetail(dish: dish)) {
                    MenuItemListing(dish: dish)
                }
            }
            .listStyle(.plain)
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare))]
    }
    
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters = !isStartersShown ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !isMainsShown ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !isDessertsShown ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !isDrinksShown ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
    }
}

#Preview {
    OrderView()
}
