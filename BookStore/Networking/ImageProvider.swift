import Foundation

public protocol ImageProvider {

    func favoriteBooks() -> Data
    func saveFavoriteBook(_ data: Data)
}
