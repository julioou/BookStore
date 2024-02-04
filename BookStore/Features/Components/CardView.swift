import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {

    let title: String
    let favorited: Bool
    let imageUrl: URL

    var body: some View {
        VStack {
            WebImage(url: imageUrl)
                .resizable()
                .frame(width: 140, height: 140)
                .scaledToFit()
                .padding(.horizontal)
                .background(.black)
                .cornerRadius(12)
            
            Text(title)
                .font(.title3)
                .foregroundColor(.white)
                .lineLimit(2)
        }

    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Card view", 
                 favorited: false,
                 imageUrl: URL(string: "https://cdn.kobo.com/book-images/cb230613-26e9-47e1-b622-27fb2c1cf00d/353/569/90/False/the-witcher-volume-4-of-flesh-and-flame.jpg")!)
    }
}
