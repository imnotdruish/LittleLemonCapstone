//
//  Main.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 3/1/25.
//

import SwiftUI

struct Main: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView()
                MenuView()
            }
        }
    }
}

#Preview {
    Main().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
