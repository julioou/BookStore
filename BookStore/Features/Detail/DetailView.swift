import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {

    private enum Constant {
        static let heartFilled = "heart.fill"
        static let heartEmpty = "heart"
    }

    @EnvironmentObject var router: Router
    @State private var showingSheet = false

    var book: BookModel
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(book.title)
                    .lineLimit(3)
                    .font(.title)
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
                if book.isFavorited {
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

            Text(book.author)
                .font(.title2)
                .font(.title.bold())
                .foregroundColor(.white)
                .padding()

            Button {
                showingSheet.toggle()
            } label: {
                ZStack {
                    Text(book.overview)
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
                    Text(book.overview)
                        .font(.title3)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                }
                .background(Color(.homeLight))
                .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            }

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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(book: .init(author: "Lorem Ipsum",
                               title: "Lorem Ipsum Lorem Ipsum",
                               overview: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum\n\nLorem Ipsum Lorem IpsumLorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum\nLorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
                               imageUrl: URL(string: "https://cdn.kobo.com/book-images/cb230613-26e9-47e1-b622-27fb2c1cf00d/353/569/90/False/the-witcher-volume-4-of-flesh-and-flame.jpg")!,
                               buyLink: nil))
    }
}
