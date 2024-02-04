import Foundation

struct BookList: Codable {

    let items: [BookDataModel]?
}

struct BookDataModel: Codable {
    let volumeInfo: VolumeInfo?
    let saleInfo: SaleInfo?
}

struct SaleInfo: Codable {
    let buyLink: String?
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?

}

struct ImageLinks: Codable {
    let thumbnail: String?
}
