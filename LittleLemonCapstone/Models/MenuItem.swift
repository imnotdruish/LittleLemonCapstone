//
//  MenuItem.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var price: String
    var itemDescription: String
    var category: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case price = "price"
        case itemDescription = "description"
        case category = "category"
    }
    
}
