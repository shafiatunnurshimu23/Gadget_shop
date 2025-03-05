//
//  Product.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

//import Foundation
//
//struct Product : Identifiable {
//    var id = UUID()
//    var name: String = ""
//    var image: String = ""
//    var description: String = ""
//    var brand: String = ""
//    var price: Int = 0
//}
//
//var productList = [
//    Product(name: "Air Buds",
//            image: "p1",
//            description: "Dual hosts, left and right ear divided design both are convenient to your use. Smart touch control, compact and light weight both well fit ear canal without burden. Life-level waterproof, well withstanding sweat Features. 13mm dynamic driver for stereo sound and type-C interface for quick charging. Comes with a long battery without embarrassment of frequent charging. Ergonomic design and feather-light weight are both precisely designed and measured to make your ears fully comfortable. BT 5.0 technology, low latency and low power consumption.",
//            brand: "Realme",
//            price: 850),
//    Product(name: "Ear Phone",
//            image: "p2",
//            description: "Dual hosts, left and right ear divided design both are convenient to your use. Smart touch control, compact and light weight both well fit ear canal without burden. Life-level waterproof, well withstanding sweat Features. 13mm dynamic driver for stereo sound and type-C interface for quick charging. Comes with a long battery without embarrassment of frequent charging. Ergonomic design and feather-light weight are both precisely designed and measured to make your ears fully comfortable. BT 5.0 technology, low latency and low power consumption.",
//            brand: "Apple",
//            price: 540),
//    Product(name: "Head Phones",
//            image: "p3",
//            description: "Dual hosts, left and right ear divided design both are convenient to your use. Smart touch control, compact and light weight both well fit ear canal without burden. Life-level waterproof, well withstanding sweat Features. 13mm dynamic driver for stereo sound and type-C interface for quick charging. Comes with a long battery without embarrassment of frequent charging. Ergonomic design and feather-light weight are both precisely designed and measured to make your ears fully comfortable. BT 5.0 technology, low latency and low power consumption.",
//            brand: "Samsung",
//            price: 1100),
//    Product(name: "Pendrives",
//            image: "p4",
//            description: "Dual hosts, left and right ear divided design both are convenient to your use. Smart touch control, compact and light weight both well fit ear canal without burden. Life-level waterproof, well withstanding sweat Features. 13mm dynamic driver for stereo sound and type-C interface for quick charging. Comes with a long battery without embarrassment of frequent charging. Ergonomic design and feather-light weight are both precisely designed and measured to make your ears fully comfortable. BT 5.0 technology, low latency and low power consumption.",
//            brand: "Transcends",
//            price: 650),
//]


import Foundation

struct Product: Identifiable, Decodable {
    var id = UUID()
    var name: String
    var brand: String
    var image: String
    var price: Double
    var description: String
    
    enum CodingKeys: String, CodingKey {
            case name, brand, image, price, description
    }
}

var productList = [Product]()


