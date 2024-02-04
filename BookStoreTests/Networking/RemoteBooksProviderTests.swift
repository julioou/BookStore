import XCTest
@testable import BookStore

final class RemoteBooksProviderTests: XCTestCase {

    func test_books_should_callWith_definedURL() throws {
        let networkingClientSpy = NetworkingClientSpy()
        let sut = RemoteBooksProvider(httpGetClient: networkingClientSpy)
        let expectedUrl = URL(string: RemoteBooksProvider.Endpoint.baseUrl + "1")

        Task {
            let _ = try await sut.books(index: 8)
            XCTAssertEqual(networkingClientSpy.url, expectedUrl)
        }
    }

    func test_books_should_return_validData() throws {
        let data = BookList.mock()
        let expectedData = data.items!

        let networkingClientSpy = NetworkingClientSpy(data: data.toData())
        let sut = RemoteBooksProvider(httpGetClient: networkingClientSpy)
        Task {
            let books = try await sut.books(index: 1)
            XCTAssertEqual(books.first?.title, expectedData.first?.volumeInfo?.title)
            XCTAssertEqual(books.first?.overview, expectedData.first?.volumeInfo?.description)
        }
    }

    func test_books_should_return_invalidData() async throws {
        let expectedError = DomainError.invalidData

        let networkingClientSpy = NetworkingClientSpy(data: "dummy data".data(using: .utf8))
        let sut = RemoteBooksProvider(httpGetClient: networkingClientSpy)

        do {
            let data = try await sut.books(index: 1)
            XCTFail("Should return unexpected error, retuns \(data)")
        } catch {
            guard let throwError = error as? DomainError else {
                XCTFail("Invalid type Error")
                return
            }
            XCTAssertEqual(throwError, expectedError)
        }
    }

    func test_books_should_return_emptyData() async throws {
        let expectedError = DomainError.emptyData
        let data = BookList.mock(isEmpty: true)
        let networkingClientSpy = NetworkingClientSpy(data: data.toData())
        let sut = RemoteBooksProvider(httpGetClient: networkingClientSpy)

        do {
            let data = try await sut.books(index: 1)
            XCTFail("Should return unexpected error, retuns \(data)")
        } catch {
            guard let throwError = error as? DomainError else {
                XCTFail("Invalid type Error")
                return
            }
            XCTAssertEqual(throwError, expectedError)
        }
    }

    func test_books_should_return_error() {
        let data = BookList.mock().toData()
        let expectedError = DomainError.unexpected

        let networkingClientSpy = NetworkingClientSpy(data: data, error: expectedError)
        let sut = RemoteBooksProvider(httpGetClient: networkingClientSpy)

        Task {
            do {
                _ = try await sut.books(index: 1)
                XCTFail("Should return unexpected error")
            } catch {
                guard let throwError = error as? DomainError else {
                    XCTFail("Invalid type Error")
                    return
                }
                XCTAssertEqual(throwError, expectedError)
            }
        }
    }
}

extension RemoteBooksProviderTests {

    class NetworkingClientSpy: HttpGetClient {

        var url: URL?
        var data: Data?
        var error: DomainError?

        init(url: URL? = nil, data: Data? = nil, error: DomainError? = nil) {
            self.url = url
            self.data = data
            self.error = error
        }

        func get(from url: URL) async throws -> Data {
            if let error = error {
                throw error
            }

            self.url = url
            guard let data = data else { throw DomainError.invalidData }
            return data
        }
    }
}

extension BookList: Datable {

    static func mock(isEmpty: Bool = false) -> BookList {
        let volumeInfo = VolumeInfo(title: "Arthur",
                                    authors: ["Ecbert"],
                                    description: "Lorem Ipsum lorem doloren ilsun",
                                    imageLinks: ImageLinks(thumbnail: "https://some-image.com"))
        let items = BookDataModel(volumeInfo: volumeInfo,
                                  saleInfo: SaleInfo(buyLink: "https://www.amazon.com"))

        return BookList(items: isEmpty ? nil : [items])
    }
}

protocol Datable: Codable {
    func toData() -> Data }

extension Datable {

    func toData() -> Data {
        try! JSONEncoder().encode(self)
    }
}


