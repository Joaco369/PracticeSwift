//
//  Refresh.swift
//  NovedadesiOS15
//
//  Created by Joaquin Villarreal on 07/05/2024.
//

import SwiftUI

struct Refresh: View {
    
    @State private var ite = "Item"
    
    var body: some View {
        NavigationView{
            List(1..<10){ item in
                Text("\(ite) \(item)")
            }
            .navigationTitle("List")
            .refreshable {
                ite = ("Recargando API")
            }
        }
    }
}

