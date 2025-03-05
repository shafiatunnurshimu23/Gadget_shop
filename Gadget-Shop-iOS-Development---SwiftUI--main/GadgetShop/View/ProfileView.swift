//
//  ProfileView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 24/11/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ProfileView: View {
    @AppStorage("uid") var userId: String = ""
    @State var userData: [String: String] = [:]
    
    var body: some View {
        
        VStack {
            ProfileHeaderView(userData: userData)
            
            VStack(alignment: .leading, spacing: 15) {
                ProfileDetailRow(title: "Name", value: userData["name"] ?? "")
                ProfileDetailRow(title: "Email", value: userData["email"] ?? "")
                ProfileDetailRow(title: "Phone", value: userData["phone"] ?? "")
            }
            .padding()
            
            Spacer()
            
            VStack {
                VStack {
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        
                        do {
                            try firebaseAuth.signOut()
                            withAnimation {
                                userId = ""
                            }
                        }
                        catch let signOutError as NSError {
                            print("Error of Signing Out: %@", signOutError)
                        }
                    }) {
                        Text("Sign Out")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding(.horizontal)
                .padding()
                .background(Color("kPrimary"))
                .cornerRadius(10)
                .padding()
            }
            .padding(.bottom, 50)
        }
        .navigationBarTitle("Profile", displayMode: .inline)
        .onAppear {
            fetchUserData()
        }
        
    }
    
    func fetchUserData() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        let usersRef = Database.database().reference().child("users").child(currentUserUID)
        
        usersRef.observeSingleEvent(of: .value) { snapshot in
            if let userData = snapshot.value as? [String: String] {
                self.userData = userData
            }
        }
    }
}

struct ProfileHeaderView: View {
    var userData: [String: String]
    
    var body: some View {
        VStack {
            Image("profile_picture") // Replace "profile_picture" with your image name
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                .shadow(radius: 10)
            
            Text(userData["name"] ?? "")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
        }
        .padding(.bottom, 20)
        .padding(.top, 50)
    }
}

struct ProfileDetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    ProfileView()
}
