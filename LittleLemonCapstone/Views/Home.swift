//
//  Home.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        Main()
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
