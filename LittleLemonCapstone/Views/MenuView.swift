//
//  MenuView.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
        
    @State var isLoaded = false
    @State var isKeyboardVisible = false

    var body: some View {
        NavigationView {
            VStack {
                HeroView()
                Spacer(minLength: 30)
                OrderView()
            }
            .onAppear {
                if !isLoaded {
                    MenuList.getMenuData(viewContext: viewContext)
                    isLoaded = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                withAnimation {
                    self.isKeyboardVisible = true
                }
                
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                withAnimation {
                    self.isKeyboardVisible = false
                }
            }
        }
    }
}

#Preview {
    MenuView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
