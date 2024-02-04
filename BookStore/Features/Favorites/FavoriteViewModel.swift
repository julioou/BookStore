import Foundation
import SwiftUI

final class FavoritesViewModel: ObservableObject {

    @Environment(\.managedObjectContext) var storageManager

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.title)]
    ) var localBooks: FetchedResults<Book>

    @Published var books: [BookModel] = []

    func loadFavorites() {
        for book in localBooks {
            guard let author = book.author,
                  let title = book.title,
                  let overview = book.overview,
                  let rawImageUrl = book.imageUrl,
                  let imageUrl = URL(string: rawImageUrl) else { return }

            books.append(BookModel(author: author,
                                   title: title,
                                   overview: overview,
                                   imageUrl: imageUrl,
                                   buyLink: URL(string: book.buyLink ?? "")))
        }
    }
}
