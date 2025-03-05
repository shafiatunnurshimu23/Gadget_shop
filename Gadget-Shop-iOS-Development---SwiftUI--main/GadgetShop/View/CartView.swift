//
//  CartView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import UserNotifications

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    @State private var isPaymentSuccessful = false
    @State var userData: [String: String] = [:]
    @State private var showToast = false // New state for showing toast
    
    var body: some View {
        ZStack {
            ScrollView {
                if cartManager.products.count > 0 {
                    ForEach(cartManager.products, id: \.id) { product in
                        CartProductView(product: product)
                    }
                    HStack {
                        Text("Your Total is ")
                        Spacer()
                        Text("$ \(String(format: "%.2f", cartManager.total))")
                            .bold()
                        
                    }
                    .padding()
                    
                    PaymentButton(action: {
                        makePaymentAndSaveOrder()
                        showToast = true
                    })
                    .padding()
                }
                else {
                    Text("Your Cart is Empty")
                        .bold()
                }
                VStack {
                    if showToast {
                        ToastView(message: "Order Placed Successfully")
                            .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    withAnimation {
                                        showToast = false
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    }
                    Spacer()
                }
            }
            .navigationTitle(Text("My Cart"))
            .padding(.top)
        }
        .padding(.bottom, 50)
    }
    
    
    
    func makePaymentAndSaveOrder() {
        
        // Prepare data for order
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        
        let usersRef = Database.database().reference().child("users").child(currentUserUID)
        
        usersRef.observeSingleEvent(of: .value) { snapshot in
            if let userData = snapshot.value as? [String: String] {
                let orderData: [String: Any] = [
                    "uid": currentUserUID,
                    "name": userData["name"] ?? "",
                    "email": userData["email"] ?? "",
                    "phone": userData["phone"] ?? "",
                    "products": cartManager.products.map { $0.name }, // Assuming you store only product names
                    "total": cartManager.total
                ]
                
                let ordersRef = Database.database().reference().child("orders").childByAutoId()
                
                ordersRef.setValue(orderData) { error, _ in
                    if let error = error {
                        print("Error saving order: \(error.localizedDescription)")
                    } else {
                        // Clear cartManager after successful order
                        cartManager.clearCart() // Call the method to clear the cart
                        isPaymentSuccessful = true
                    }
                }
            }
        }
    }
}

struct ToastView: View {
    let message: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(message)
                .foregroundColor(.white)
                .padding()
            Spacer()
        }
        .background(Color.black.opacity(0.7))
        .cornerRadius(10)
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

#Preview {
    CartView()
}
