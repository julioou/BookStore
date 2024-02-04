import SwiftUI

struct Home: View {
    
    private struct Constants {
        static let headerTitle = "Book Store"
        static let defaultSpacing: CGFloat = 30
    }

    @EnvironmentObject var router: Router
    @StateObject var viewModel = HomeViewModel()

    var columns = [GridItem(), GridItem()]

    var body: some View {
        VStack {
            HStack {
                Text(Constants.headerTitle)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 36)
                    .padding(.bottom, 12)
                Spacer()
                Button {
                    router.navigate(to: .favorites)
                } label: {
                    Image(systemName: "heart.rectangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36)
                        .foregroundColor(.white)
                        .padding(.horizontal, 36)
                }
            }
            .frame(height: 80)
            .background(Color(.home))
            .padding(.zero)

            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: Constants.defaultSpacing) {
                    ForEach(viewModel.books) { book in
                        CardView(title: book.title,
                                 favorited: book.isFavorited,
                                 imageUrl: book.imageUrl)
                        .onAppear {
                            viewModel.fetchBooksIfNeeded(for: book)
                        }
                        .onTapGesture {
                            router.navigate(to: .detail(bookInfo: book))
                        }
                    }
                }
                .padding()
            }.onAppear {
                viewModel.fetchBooks()
            }
        }
        .background(Color(.homeLight))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
