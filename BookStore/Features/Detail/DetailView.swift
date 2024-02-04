import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {

    private enum Constant {
        static let heartFilled = "heart.fill"
        static let heartEmpty = "heart"
    }

    @Environment(\.managedObjectContext) var storageManager
    @EnvironmentObject var router: Router
    @State private var showingSheet = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)],
        animation: .default)
    private var storedBooks: FetchedResults<Book>

    @State var book: BookModel
    
    var viewModel = DetailViewModel()

    var body: some View {

        VStack {
            HStack(alignment: .top) {
                Text(book.title)
                    .lineLimit(3)
                    .font(.title)
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
                Button {
                    viewModel.buttonAction(storedBooks: storedBooks, bookModel: book)
                } label: {
                    if viewModel.isFavorited(storedBooks, bookModel: book) {
                        Image(systemName: Constant.heartFilled)
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.red)
                            .frame(width: 32, height: 32)
                            .padding(.top, 4)
                    } else {
                        Image(systemName: Constant.heartEmpty)
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.gray)
                            .frame(width: 32, height: 32)
                            .padding(.top, 4)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .padding(.horizontal, 16)

            WebImage(url: book.imageUrl)
                .resizable()
                .frame(width: 140, height: 240)
                .scaledToFit()
                .padding()
                .background(.black)
                .cornerRadius(12)

            Text("By: " + book.author)
                .font(.title2)
                .font(.title.bold())
                .foregroundColor(.white)
                .padding()

            ExpandableText(text: book.overview)

            .padding(.bottom, 20)

            if let url = book.buyLink {
                Button {
                    UIApplication.shared.open(url)
                } label: {
                    Text("Buy now")
                        .font(.title.bold())
                        .frame(height: 80)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.indigo)
                        .cornerRadius(12)
                        .padding(26)
                }
                .padding(.bottom, 22)
            }
            Spacer()
        }
        .background(Color(.homeLight))
        .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}
