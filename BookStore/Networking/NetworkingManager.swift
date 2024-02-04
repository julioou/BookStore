import Foundation

public protocol HttpGetClient {
    func get(from url: URL) async throws -> Data
}

class NetworkingManager: HttpGetClient {
    
    let session = URLSession.shared

    func get(from url: URL) async throws -> Data {
        let (data, _) = try await session.data(from: url)
        return data
    }
}
