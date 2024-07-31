//
//  ContentView.swift
//  NovedadesiOS15
//
//  Created by Joaquin Villarreal on 06/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    enum Campos {
        case name
        case lastName
        case email
    }
    
    
    @State private var name = ""
    @State private var lastName = ""
    @State private var email = ""
    @FocusState private var focus : Campos?
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .focused($focus, equals: .name)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.continue)
            TextField("LastName", text: $lastName)
                .focused($focus, equals: .lastName)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.continue)
            TextField("Email", text: $email)
                .focused($focus, equals: .email)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.continue)
                .keyboardType(.emailAddress)
        }
        .padding(.all)
        .onSubmit {
            switch focus{
            case .name:
                focus = .lastName
            case .lastName:
                focus = .email
            default:
                print("Saved")
            }
        }
    }
}
