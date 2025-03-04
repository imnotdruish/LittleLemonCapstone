//
//  Home.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        TabView {
            Tab("Main", systemImage: "menucard") {
                Main()
                    .navigationBarBackButtonHidden(true)
            }
            Tab("Profile", systemImage: "person.crop.circle.fill") {
                UserProfileView()
            }
        }
    }
}

#Preview {
    Home().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
