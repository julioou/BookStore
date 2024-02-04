import Foundation

enum ModelParser {

    static func dataToModel(from books: [BookDataModel]) -> [BookModel] {
        var model: [BookModel] = []

        for book in books {
            guard let rawAuthors = book.volumeInfo?.authors,
                  let title = book.volumeInfo?.title,
                  let overview = book.volumeInfo?.description,
                  let rawImageUrl = book.volumeInfo?.imageLinks?.thumbnail,
                  let imageUrl = URL(string: rawImageUrl) else { return [] }

            let authors = rawAuthors.joined(separator: ", ")

            var buyLink: URL? = nil

            if let rawBuyLink = book.saleInfo?.buyLink {
                buyLink = URL(string: rawBuyLink)
            }

            model.append(BookModel(author: authors,
                                   title: title,
                                   overview: overview,
                                   imageUrl: imageUrl,
                                   buyLink: buyLink))
        }

        return  model
    }
}
