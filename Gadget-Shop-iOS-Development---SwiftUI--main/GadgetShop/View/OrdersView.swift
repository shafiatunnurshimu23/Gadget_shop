//
//  OrdersView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 28/11/23.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct OrderedProduct: Hashable {
    let products: [String]
    let total: Double
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(products)
        hasher.combine(total)
    }
    
    static func == (lhs: OrderedProduct, rhs: OrderedProduct) -> Bool {
        return lhs.products == rhs.products && lhs.total == rhs.total
    }
}

struct OrdersView: View {
    @State private var orderedProducts: [OrderedProduct] = []
    
    var body: some View {
        VStack {
            Text("My Orders")
                .font(.largeTitle)
                .padding()
                .foregroundColor(Color("kPrimary"))
            List {
                ForEach(orderedProducts, id: \.self) { orderedProduct in
                    VStack(alignment: .leading) {
                        Text("Products: \(orderedProduct.products.joined(separator: ", "))")
                        Text("Total: $\(String(format: "%.2f", orderedProduct.total))")
                    }
                }
            }
            .navigationBarTitle("Orders")
            .onAppear {
                fetchOrdersForCurrentUser()
        }
        }
    }
    
    func fetchOrdersForCurrentUser() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        let ordersRef = Database.database().reference().child("orders")
        
        ordersRef.queryOrdered(byChild: "uid").queryEqual(toValue: currentUserUID).observeSingleEvent(of: .value) { snapshot in
            var fetchedOrderedProducts: [OrderedProduct] = []
            for child in snapshot.children {
                if let orderSnapshot = child as? DataSnapshot,
                   let orderData = orderSnapshot.value as? [String: Any],
                   let products = orderData["products"] as? [String],
                   let total = orderData["total"] as? Double {
                    let orderedProduct = OrderedProduct(products: products, total: total)
                    fetchedOrderedProducts.append(orderedProduct)
                }
            }
            self.orderedProducts = fetchedOrderedProducts
        }
    }
}



#Preview {
    OrdersView()
}
