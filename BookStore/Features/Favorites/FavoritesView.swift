//
//  FavoritesView.swift
//  BookStore
//
//  Created by Julio Cesar on 03/02/24.
//

import SwiftUI

struct FavoritesView: View {
    private struct Constants {
        static let defaultSpacing: CGFloat = 30
    }

    @StateObject var viewModel = FavoritesViewModel()

    var columns = [GridItem(), GridItem()]

    @State var favorited = false

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: Constants.defaultSpacing) {
//                    ForEach(books) { book in
//                        CardView(title: book.title, favorited: favorited)
//                            .onTapGesture {
//                                favorited.toggle()
//                            }
//                    }
                }
                .padding()
            }.background(Color(.home))
        }.background(Color(.homeLight))
    }
}

#Preview {
    FavoritesView()
}
