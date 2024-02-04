import Foundation
import SwiftUI

class DetailViewModel {

    func buttonAction(storedBooks: FetchedResults<Book>,
                      bookModel: BookModel) {
        if !isFavorited(storedBooks, bookModel: bookModel) {
            add(storedBooks, bookModel: bookModel)
        } else {
            delete(storedBooks, bookModel: bookModel)
        }
    }


    func isFavorited(_ storedBooks: FetchedResults<Book>,
                     bookModel: BookModel) -> Bool {
        for stored in storedBooks {
            if bookModel.title == stored.title {
                return true
            }
        }
        return false
    }
}

private extension DetailViewModel {

    func add(_ storedBooks: FetchedResults<Book>, bookModel: BookModel) {
        let book = Book(context: StorageManager.shared.viewContext)
        book.title = bookModel.title
        book.author = bookModel.author
        book.overview = bookModel.overview
        book.imageUrl = bookModel.imageUrl.absoluteString
        book.buyLink = bookModel.buyLink?.absoluteString
        StorageManager.shared.saveContext()
    }

    func delete(_ storedBooks: FetchedResults<Book>, bookModel: BookModel) {
        if let stored = storedBooks.first(where: { $0.title == bookModel.title }) {
            StorageManager.shared.viewContext.delete(stored)
        }
        StorageManager.shared.saveContext()
    }
}
