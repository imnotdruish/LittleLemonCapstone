//
//  LittleLemonCapstoneApp.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/27/25.
//

import SwiftUI

@main
struct LittleLemonCapstoneApp: App {

    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            OnBoardingView().environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
