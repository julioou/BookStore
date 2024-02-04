//
//  ExpandableText.swift
//  BookStore
//
//  Created by Julio Cesar on 04/02/24.
//

import SwiftUI

struct ExpandableText: View {
    @State var showingSheet: Bool = false
    var text: String

    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            ZStack {
                Text(text)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .lineLimit(4)

                Image(systemName: "rectangle.expand.vertical")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
            }
        }
        .sheet(isPresented: $showingSheet) {
            ScrollView {
                Text(text)
                    .font(.title3)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
            }
            .background(Color(.homeLight))
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
        }
    }
}

#Preview {
    ExpandableText(text: "lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem\nlorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem\nlorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem lorem ipsum lorem")
}
