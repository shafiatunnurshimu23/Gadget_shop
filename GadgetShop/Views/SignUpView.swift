//
//  SignUpView.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 23/11/23.
//

import SwiftUI

import Firebase
import FirebaseAuth
import FirebaseDatabase

struct SignUpView: View {
    @Binding var currentShowingView: String
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var phone: String = ""
    
    @AppStorage("uid") var userId: String = ""
    
    private func isValidPassword(_ password: String) -> Bool {
        // minimum 6 characters
        // 1 upper case letter
        // 1 special character
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Text("Create an Account").font(.largeTitle).bold()
                
                    Spacer()
                }
                .padding(.top, 20)
                
                HStack {
                    Spacer()
                    Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 150)
                    Spacer()
                }

                
                Spacer()
                
                HStack {
                    Image(systemName: "star")
                    TextField("Full Name", text: $name)
                    
                    Spacer()
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black)
                )
                .padding()
                
                HStack {
                    Image(systemName: "phone")
                    TextField("Phone Number", text: $phone)
                    
                    Spacer()
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black)
                )
                .padding()
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    if(email.count != 0) {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark").fontWeight(.bold).foregroundColor(email.isValidEmail() ? .green : .red)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black)
                )
                .padding()
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    
                    if(password.count != 0) {
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark").fontWeight(.bold).foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black)
                )
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "login"
                    }
                }) {
                    Text("Already Have an Accout?").foregroundColor(.cyan.opacity(0.9))
                }
                
                Spacer()
                Spacer()
                
                Button {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            userId = authResult.user.uid
                            
                            let user = Auth.auth().currentUser
                                if let user = user {
                                    let uid = user.uid
                                    let userData = [
                                        "name": name,
                                        "phone": phone,
                                        "email": email
                                    ]
                                    
                                    let dbRef = Database.database().reference().child("users").child(uid)
                                        dbRef.setValue(userData) { error, _ in
                                        if let error = error {
                                            print("Error saving data: \(error)")
                                        } else {
                                            print("Data saved successfully")
                                        }
                                    }
                                }
                        }
                        
                    }
                    
                    
                } label: {
                    Text("Sign Up").foregroundColor(.white).font(.title3).bold()
                        
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                        .background(
                            RoundedRectangle(cornerRadius: 10).fill(Color.black)
                        )
                        .padding(.horizontal)
                }
            }
        }
    }
}

