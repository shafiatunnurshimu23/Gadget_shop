//
//  CartProductView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

import SwiftUI

struct CartProductView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        HStack(spacing: 20) {
//            Image(product.image)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 70)
//                .cornerRadius(9)
            
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
            .aspectRatio(contentMode: .fit)
            .frame(width: 70)
            .cornerRadius(9)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .bold()
                
                Text("$ \(String(format: "%.2f", product.price))")
                    .bold()
            }
            .padding()
            
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    cartManager.removeFromCart(product: product)
                }
        }
        .padding(.horizontal)
        .background(Color("kSecondary"))
        .cornerRadius(12)
        .frame(width: .infinity, alignment: .leading)
        .padding()
    }
}

struct CartProductView_Previews: PreviewProvider {
    static var previews: some View {
        CartProductView(product: productList[1])
            .environmentObject(CartManager())
    }
}

#Preview {
    CartProductView(product: productList[2])
}
