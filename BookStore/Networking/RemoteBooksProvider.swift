import Foundation

protocol BooksProvider {

    func books(index: Int) async throws -> [BookModel]
}

final class RemoteBooksProvider: BooksProvider {
    
    enum Endpoint {
        static let baseUrl = "https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=10&startIndex="
    }

    let httpGetClient: HttpGetClient

    init(httpGetClient: HttpGetClient = NetworkingManager()) {
        self.httpGetClient = httpGetClient
    }

    func books(index: Int) async throws -> [BookModel] {
        guard let url = URL(string: Endpoint.baseUrl + String(index)) else { throw DomainError.invalidUrl }

        let data = try await httpGetClient.get(from: url)
        let list = try parseToBooks(from: data)

        guard let rawBooks = list.items else { throw DomainError.emptyData }
        let books = ModelParser.dataToModel(from: rawBooks)
        return books
    }

    private func parseToBooks(from data: Data) throws -> BookList {
        do {
            return try JSONDecoder().decode(BookList.self, from: data)
        } catch {
            throw DomainError.invalidData
        }
    }
}
