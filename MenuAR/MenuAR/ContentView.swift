//
//  ContentView.swift
//  MenuAR
//
//  Created by Joaquin Villarreal on 13/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination: Home()){
                Text("Open increased menu")
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            .navigationTitle("Restaurant")
        }
    }
}
