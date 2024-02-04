import Foundation
import SwiftUI

final class FavoritesViewModel: ObservableObject {

    @Published var books: [BookModel] = []

    func updateFavorites(with storedBook: FetchedResults<Book>) {
        var updatedBooks: [BookModel] = []

        for book in storedBook {
            guard let author = book.author,
                  let title = book.title,
                  let overview = book.overview,
                  let rawImageUrl = book.imageUrl,
                  let imageUrl = URL(string: rawImageUrl) else { return }

            updatedBooks.append(BookModel(author: author,
                                          title: title,
                                          overview: overview,
                                          imageUrl: imageUrl,
                                          buyLink: URL(string: book.buyLink ?? ""),
                                          isFavorited: true))
        }
        books = updatedBooks
    }
}
