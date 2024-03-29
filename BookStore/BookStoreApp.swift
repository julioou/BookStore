//
//  BookStoreApp.swift
//  BookStore
//
//  Created by Júlio Santos on 29/01/2024.
//

import SwiftUI

@main
struct BookStoreApp: App {
    let storageManager = StorageManager.shared
    @ObservedObject var router = Router()
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView()
                    .environment(\.managedObjectContext, storageManager.viewContext)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .favorites:
                            FavoritesView()
                                .environment(\.managedObjectContext,
                                              storageManager.viewContext)
                        case .detail(let bookDetail):
                            DetailView(book: bookDetail)
                                .environment(\.managedObjectContext,
                                              storageManager.viewContext)
                        }
                    }
            }
            .environmentObject(router)
        }
        .onChange(of: scenePhase) { _ in
            storageManager.saveContext()
        }
    }
}
