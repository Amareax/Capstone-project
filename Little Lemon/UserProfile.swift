//
//  UserProfile.swift
//  Little Lemon
//
//  Created by YOLISA MAGIBILE on 2023/08/27.
//

import SwiftUI

struct UserProfile: View {
    
    let firstName = UserDefaults.standard.string(forKey: customerFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: customerLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: customerEmail) ?? ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            
            Text("Personal information")
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(50)
                .padding()
            Text("First Name: \(firstName)")
            Text("Last Name: \(lastName)")
            Text("Email: \(email)")
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                    self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
