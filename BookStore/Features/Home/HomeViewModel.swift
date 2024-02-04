import Foundation
import Combine


class HomeViewModel: ObservableObject {
    private enum Constants {
        static let incrementalFetchAmount: Int = 10
    }
    @Published var books: [BookModel] = []

    var index: Int = 0
    let provider: BooksProvider

    init(provider: BooksProvider = RemoteBooksProvider()) {
        self.provider = provider
    }

    func fetchBooks() {
        Task {
            do {
                let model = try await provider.books(index: index)

                DispatchQueue.main.async {
                    self.books += model
                }
            } catch {
                
            }
        }
    }

    func fetchBooksIfNeeded(index: Int ) {
        guard index == books.count && self.index < 50 else { return }
        self.index += Constants.incrementalFetchAmount
        fetchBooks()
    }

    func fetchBooksIfNeeded(for book: BookModel) {
        let index = books.firstIndex(of: book) ?? 0
        guard index == (books.count - 1) && self.index < 90 else { return }
        self.index += Constants.incrementalFetchAmount
        books[index].isFavorited.toggle()
        fetchBooks()
    }
}
