//
//  AvatarView.swift
//  LittleLemonCapstone
//
//  Created by Dan June on 3/3/25.
//

import SwiftUI

struct AvatarView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Avatar")
                .font(.leadText())
                .padding(.leading)
            HStack(spacing: 0) {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.trailing)
                Button("Change"){}
                    .buttonStyle(ButtonAccentReverse())
                Button("Remove"){}
                    .buttonStyle(ButtonAccent())
                Spacer()
            }
        }
    }
}

#Preview {
    AvatarView()
}
