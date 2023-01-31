//
//  TextView.swift
//  NameReclaim
//
//  Created by alec stevenson on 10/11/22.
//

import SwiftUI

struct TextView: View {
    @State private var username: String = "E"
    
    var body: some View {
        VStack {
            if !username.isEmpty {
                Text("Welcome \(username)!")
            }
            TextField("Username", text: $username)
            Button("Autofill") {
                username = "Alec" // <1>
            }
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
