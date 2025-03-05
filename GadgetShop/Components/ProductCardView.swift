//
//  ProductCartView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

import SwiftUI

struct ProductCardView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    
    var body: some View {
        ZStack {
            Color("kSecondary")
            
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading) {
                    
                    AsyncImage(url: URL(string: product.image.trimmingCharacters(in: .whitespacesAndNewlines))) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                        case .failure(_):
                            // Placeholder or error handling
                            Image("p1")
                                .resizable()
                        case .empty:
                            ProgressView() // Loading indicator
                        @unknown default:
                            fatalError()
                        }
                    }
                    .frame(width: 175, height: 160)
                    .cornerRadius(12)

                    
                    Text(product.name)
                        .font(.headline)
                        .padding(.vertical, 1)
                    
                    Text(product.brand)
                        .foregroundColor(.gray)
                        .font(.caption)
                        .padding(.vertical, 0.5)
                    
                    Text("$ \(String(format: "%.2f", product.price))")
                        .foregroundColor(.black)
                    .bold()                }
                
                Button{
                    cartManager.addToCart(product: product)
                } label:{
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(Color("kPrimary"))
                        .frame(width: 35, height: 35)
                        .padding(.trailing)
                    
                }
            }
        }
        .frame(width: 185, height: 260)
        .cornerRadius(15)
    }
    
    
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: productList[2])
            .environmentObject(CartManager())
    }
}

//extension Image {
//    func data(url:URL) -> Self {
//        if let data = try? Data(contentsOf: url) {
//            return Image(uiImage: UIImage(data: data)!)
//        }
//        return self
//    }
//}

#Preview {
    ProductCardView(product: productList[1])
}
