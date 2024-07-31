//
//  ContentView.swift
//  JSON
//
//  Created by Joaquin Villarreal on 10/04/2024.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var login: PostViewModel
    
    var body: some View {
        Group{
            if login.authenticated == 0 {
                Login()
            } else if login.authenticated == 1 {
                Home()
            } else if login.authenticated == 2 {
                VStack{
                    Text("Usuario y/o Contraseña incorrecta")
                    Button(action: {
                        login.authenticated = 0
                    }){
                        Text("Regresar")
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
