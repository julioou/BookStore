import SDWebImageSwiftUI
import SwiftUI

struct FavoritesCardView: View {
    var title: String
    var imageUrl: URL

    var body: some View {
        VStack {
            HStack {
                Spacer()
                WebImage(url: imageUrl)
                    .resizable()
                    .frame(width: 140, height: 140)
                    .scaledToFit()
                    .background(.black)
                    .cornerRadius(12)
                    .padding(.top)
                Spacer()
            }
            Text(title)
                .font(.title2)
                .foregroundColor(.white)
                .lineLimit(2)
                .padding()
        }
    }
}
