//
//  ProductDetailsView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

import SwiftUI

struct ProductDetailsView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
//        ScrollView {
            ZStack {
                Color.white
                
                VStack(alignment: .leading) {
                    ZStack(alignment: .topTrailing) {

                        
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
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 300)
                        
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.top, 65)
                            .padding(.trailing, 20)
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text(product.name)
                                .font(.title2 .bold())
                            
                            Spacer()
                            Text("$ \(String(format: "%.2f", product.price))")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .background(Color("kSecondary"))
                                .cornerRadius(12)
                        }
                        .padding(.vertical)
                        
                        HStack {
                            HStack(spacing: 10) {
                                ForEach(0..<5) { index in
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.yellow)
                                }
                                Text("(4.5)")
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "minus.square.fill")
                                        .foregroundColor(Color("kPrimary"))
                                })
                                Text("1")
                                Button(action: {}, label: {
                                    Image(systemName: "plus.square.fill")
                                        .foregroundColor(Color("kPrimary"))
                                })
                            }
                        }
                        
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        ScrollView {
                            VStack(alignment: .leading) {
                                
                                Text(product.description)
                            }
                        }
                        
                        
                        PaymentButton(action: {
                            cartManager.addToCart(product: product)
                        })
                            .frame(width: .infinity, height: 35)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .offset(y: -30)
                    .padding(.bottom, 20)
                }
            }
//        }
        .ignoresSafeArea(edges: .top)
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: productList[1])
    }
}


#Preview {
    ProductDetailsView(product: productList[1])
}
