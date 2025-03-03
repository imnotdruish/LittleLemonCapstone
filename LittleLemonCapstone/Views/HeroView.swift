//
//  HeroView.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 2/28/25.
//

import SwiftUI

struct HeroView: View {
        
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.accentColor)
            VStack(alignment: .leading){
                Text("Little Lemon")
                    .font(.displayFont())
                    .foregroundStyle(Color.llYellow)
                HStack{
                    VStack(alignment: .leading){
                        Text("Chicago")
                            .font(.subTitleFont())
                            .foregroundStyle(Color.llWhite)
                            .padding(.bottom, 2)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.highlightText())
                            .foregroundStyle(Color.llWhite)
                    }
                    Spacer(minLength: 10)
                    Image("Hero-Image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 125, maxHeight: 140)
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                }
                .offset(y: -25)
            }
            .padding(.horizontal, 20)
        }
        .frame(maxHeight: 250)
    }
}

#Preview {
    HeroView()
}
