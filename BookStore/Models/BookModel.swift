//
//  BookModel.swift
//  BookStore
//
//  Created by Julio Cesar on 03/02/24.
//

import Foundation

struct BookModel: Identifiable, Hashable {
    let id = UUID()
    let author: String
    let title: String
    let overview: String
    let imageUrl: URL
    let buyLink: URL?
    var isFavorited: Bool = false

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
