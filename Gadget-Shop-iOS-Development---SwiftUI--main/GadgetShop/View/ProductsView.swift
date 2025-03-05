//
//  ProductsView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var cartManager: CartManager
    
    @State var productList = [Product]()
    
    var column = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: column, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
//                        ProductCardView(product: product)
                        NavigationLink{
                            ProductDetailsView(product: product)
                        } label: {
                            ProductCardView(product: product)
                                .environmentObject(cartManager)
                        }
                    }
                }
                .padding()
            }
            .padding(.bottom, 50)
            .navigationTitle(
                Text("All Gadgets")
            )   
            .onAppear {
                fetchProducts()
            }
        }
    }
    
    func fetchProducts() {
            guard let apiUrl = URL(string: "https://api.myjson.online/v1/records/d55aac69-27ff-4278-be22-39b2efc710b2") else {
                return
            }

            let session = URLSession.shared

            let task = session.dataTask(with: apiUrl) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let productsData = jsonResult?["data"] as? [[String: Any]] {
                        self.productList = productsData.compactMap { productData in
                            if let name = productData["name"] as? String,
                               let brand = productData["brand"] as? String,
                               let image = productData["image"] as? String,
                               let price = productData["price"] as? Double,
                               let description = productData["description"] as? String {
                                return Product(name: name, brand: brand, image: image, price: price, description: description)
                            }
                            return nil
                        }
                        print("Products fetched successfully:")
                        print(self.productList)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            task.resume()
        }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
            .environmentObject(CartManager())
    }
}

#Preview {
    ProductsView()
}
