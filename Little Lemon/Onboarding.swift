//
//  Onboarding.swift
//  Little Lemon
//
//  Created by YOLISA MAGIBILE on 2023/08/26.
//

import SwiftUI

let customerFirstName = "name"
let customerLastName = "surname"
let customerEmail = "mail"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                                 EmptyView()
                             }
                TextField(
                    "First Name",
                    text: $firstName
                )
                .padding()
                .disableAutocorrection(true)
                
                TextField(
                    "Last Name",
                    text: $lastName
                )
                .padding()
                .disableAutocorrection(true)
                TextField(
                        "Email",
                        text: $email
                    )
                .padding()
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                Button("Register") {
                    
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: customerFirstName)
                        UserDefaults.standard.set(lastName, forKey: customerLastName)
                        UserDefaults.standard.set(email, forKey: customerEmail)
                        isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    }
                }
                .padding()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }

        }
    }
    
    
    
    struct Onboarding_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding()
        }
    }
}
