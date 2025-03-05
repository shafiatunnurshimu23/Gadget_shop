//
//  HomePageView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var cartManager: CartManager
    
    @State var productList = [Product]()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack(alignment: .top) {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        AppBar()
                        
                        SearchView()
                        
                        ImageSliderView()
                        
                        HStack {
                            Text("New Arrivals")
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            NavigationLink(destination: {
                                ProductsView()
                            }, label: {
                                Image(systemName: "circle.grid.2x2.fill")
                                    .foregroundColor(Color("kPrimary"))
                            })
                            
                        }
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(productList, id: \.id) {product in
                                    NavigationLink{
                                        ProductDetailsView(product: product)
                                    } label: {
                                        ProductCardView(product: product)
                                            .environmentObject(cartManager)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            .onAppear {
                fetchProducts()
            }
        }
        .environmentObject(cartManager)
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

struct AppBar: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "location.north.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing)
                    
                    Text("Khulna, Bangladesh")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    NavigationLink(destination: CartView()
                        .environmentObject(cartManager)) {
                            CartButton(numberOfProducts: cartManager.products.count)
                        }
                }
                Text("Find the best \n")
                    .font(.largeTitle .bold())
                
                + Text("Gadgets")
                    .font(.largeTitle .bold())
                    .foregroundColor(Color("kPrimary"))
                
                + Text(" Here")
                    .font(.largeTitle .bold())
            }
        }
        .padding()
        .environmentObject(CartManager())
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(CartManager())
    }
}

#Preview {
    HomePageView()
}


