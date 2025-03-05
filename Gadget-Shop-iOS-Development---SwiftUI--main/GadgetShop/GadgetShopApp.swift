//
//  GadgetShopApp.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 19/11/23.
//

import SwiftUI
import FirebaseCore

@main
struct GadgetShopApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
