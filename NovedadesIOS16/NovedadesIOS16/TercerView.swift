//
//  TercerView.swift
//  NovedadesIOS16
//
//  Created by Joaquin Villarreal on 01/07/2024.
//

import SwiftUI

struct TercerView: View {
    
    var text: Int
    @EnvironmentObject private var state: returnRoot
    
    var body: some View {
        VStack{
            Text("Holii: \(text)")
            Button("Regresar al root"){
                state.goRoot()
            }
        }
    }
}
