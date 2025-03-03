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
//                            .font(Font.custom("Kailasa", size: 32))
                            .font(.subTitleFont())
                            .foregroundStyle(Color.llWhite)
                            .padding(.bottom, 2)
                        Text("We are a family owned\n Mediterranean restaurant,\n focused on traditional\n recipes served with a\n modern twist.")
                            .font(Font.custom("Kailasa", size: 18))
                            .foregroundStyle(Color.llWhite)
                    }
                    Spacer(minLength: 10)
                    Image("Hero-Image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 125, maxHeight: 150)
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                }
                .offset(y: -15)
            }
            .padding(.horizontal, 20)
        }
        .frame(maxHeight: 225)
    }
}

#Preview {
    HeroView()
}
