//
//  Modales.swift
//  NovedadesIOS16
//
//  Created by Joaquin Villarreal on 26/06/2024.
//

import SwiftUI

struct Modales: View {
    
    @State private var show = false
    
    var body: some View {
        ZStack{
            Color.orange.ignoresSafeArea(.all)
            Button("Open Image"){
                show.toggle()
            }.sheet(isPresented: $show, content: {
                Text("Window Modal")
                    .presentationDetents([.medium, .custom])
            })
        }
    }
}

extension PresentationDetent {
    static let custom = Self.height(200)
}
