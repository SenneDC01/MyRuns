//
//  FeedView.swift
//  MyRuns
//
//  Created by Senne De Cock on 16/10/2024.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView {
            FeedItem()
            FeedItem()
            FeedItem()
        }
    }
}

#Preview {
    FeedView()
}
