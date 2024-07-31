//
//  SecondView.swift
//  Navigation
//
//  Created by Joaquin Villarreal on 04/04/2024.
//

import SwiftUI

struct SecondView: View {
    
    var texto: String
    
    var body: some View {
            Text("SecondView")
        .navigationTitle(texto)
        NavigationLink(destination: TercerView()){
            Text("Go to TercerView")
        }
    }
}
