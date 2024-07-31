//
//  Button.swift
//  NovedadesiOS15
//
//  Created by Joaquin Villarreal on 06/05/2024.
//

import SwiftUI

struct Buttons: View {
    
    @State private var on = false
    
    var body: some View {
        VStack{
            
            Toggle("Active", isOn: $on)
                .toggleStyle(.button)
                .tint(.blue)
            
            Button("Saved"){
                
            }
            .buttonStyle(.bordered)
            .tint(.red)
            
            Button(action:{
                //
            }){
                Text("Saved").frame(maxWidth: 300)
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            
            ControlGroup{
                
            Button(role: .destructive){
                
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
                Button(){
                    
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
            }
        }
    }
}
