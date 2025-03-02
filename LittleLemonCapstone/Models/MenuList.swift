//
//  MenuList.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import Foundation
import CoreData

struct MenuList: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
    static func getMenuData(viewContext: NSManagedObjectContext){
        PersistenceController.shared.clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)
        
        // Create the request
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, reponse, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let menuList = try? decoder.decode(MenuList.self, from: data) {
                    for dish in menuList.menu {
                        let newDish = Dish(context: viewContext)
                        newDish.title = dish.title
                        newDish.image = dish.image
                        newDish.price = dish.price
                        newDish.itemDescription = dish.itemDescription
                        newDish.category = dish.category
                    }
                    try? viewContext.save()
                } else {
                    print(error.debugDescription.description)
                }
            } else {
                print(error.debugDescription.description)
            }
        }
        task.resume()
    }
}
