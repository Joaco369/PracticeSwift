//
//  Home.swift
//  JSON
//
//  Created by Joaquin Villarreal on 10/04/2024.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var login : PostViewModel
    @StateObject var json = Model1ViewModel()
    
    var body: some View {
        NavigationView{
            if json.datosModelo.isEmpty{
                ProgressView()
            } else {
                List(json.datosModelo, id: \.id){ item in
                    VStack(alignment: .leading){
                        Text(item.name)
                        Text(item.address.geo.lat)
                    }
                }.navigationBarTitle("JSON")
                .navigationBarItems(leading:
                                            Button(action: {
                        UserDefaults.standard.removeObject(forKey: "sesion")
                        login.authenticated = 0
                    }){
                        Text("Exit")
                    }
                                    , trailing:
                                        NavigationLink(destination: Home2()){
                    Text("Next")
                }
                    )
            }
        }
    }
}

#Preview {
    Home()
}
