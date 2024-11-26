//
//  FeedItem.swift
//  MyRuns
//
//  Created by Senne De Cock on 16/10/2024.
//

import SwiftUI

struct FeedItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle") // veranderen naar Image
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("Senne De Cock")
                Spacer()
            }
            
            Text("Ochtend run met de collega's")
                .padding(.vertical, 8)
            
            Image(.defaultImageJpg)
                .resizable()
                .scaledToFit()
        }
        .scaledToFit()
        .padding()
    }
}

#Preview {
    FeedItem()
}
