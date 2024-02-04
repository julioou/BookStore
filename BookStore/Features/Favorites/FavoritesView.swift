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

    @Environment(\.managedObjectContext) var storageManager

    @EnvironmentObject var router: Router
    @StateObject var viewModel = FavoritesViewModel()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)],
        animation: .default)
    private var storedBooks: FetchedResults<Book>

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView {
                ForEach(viewModel.books) { book in
                    FavoritesCardView(title: book.title,
                                      imageUrl: book.imageUrl)
                    .onTapGesture {
                        router.navigate(to: .detail(bookInfo: book))
                    }
                }
            }
            .background(Color(.home))
        }
        .background(Color(.homeLight))
        .onAppear {
            viewModel.updateFavorites(with: storedBooks)
        }
    }
}

#Preview {
    FavoritesView().environment(\.managedObjectContext,
                                 StorageManager.preview.viewContext)
}
