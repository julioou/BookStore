import SwiftUI

final class Router: ObservableObject {

    public enum Destination: Hashable {
        static let id = UUID()

        case favorites
        case detail(bookInfo: BookModel)

        func hash(into hasher: inout Hasher) {
            hasher.combine(Self.id)
        }
    }

    @Published var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
