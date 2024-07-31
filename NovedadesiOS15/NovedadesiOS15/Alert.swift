//
//  Alert.swift
//  NovedadesiOS15
//
//  Created by Joaquin Villarreal on 06/05/2024.
//

import SwiftUI

struct Alert: View {
    
    @State private var show1 = false
    @State private var show2 = false
    
    var body: some View {
        VStack{
            Button("Show Alert"){
                show1.toggle()
            }
            .alert("Message of the Alert", isPresented: $show1) {
                Button("Acepted", role: .none){}
                Button("Delete", role: .destructive){}
            }
            
            Button("Open menu"){
                show2.toggle()
            }
            .confirmationDialog("Title", isPresented: $show2) {
                Button("Acepted", role: .none){}
                Button("Delete", role: .destructive){}
            }
        }
    }
}
