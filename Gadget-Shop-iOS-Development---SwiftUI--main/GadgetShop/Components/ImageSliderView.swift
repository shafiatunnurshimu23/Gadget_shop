//
//  ImageSliderView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

import SwiftUI

struct ImageSliderView: View {
    @State private var currentIndex =  0
    var sliders: [String] = ["banner1", "banner2", "banner3", "banner4"]
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack() {
                ZStack(alignment: .trailing) {
                    Image(sliders[currentIndex])
                        .resizable()
                        .frame(width: .infinity, height: 180)
                        .scaledToFit()
                        .cornerRadius(15)
                }
            }
            
            HStack {
                ForEach(0..<sliders.count) { index in
                    Circle()
                        .fill(self.currentIndex == index ? Color("kPrimary") : Color("kSecondary"))
                        .frame(width: 10, height: 10)
                }
            }
            .padding()
        }
        .padding()
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                if self.currentIndex + 1 == self.sliders.count {
                    self.currentIndex = 0
                }
                else {
                    self.currentIndex += 1
                }
            }
        }
    }
}

#Preview {
    ImageSliderView()
}
