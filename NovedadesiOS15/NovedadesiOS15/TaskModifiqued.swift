//
//  TaskModifiqued.swift
//  NovedadesiOS15
//
//  Created by Joaquin Villarreal on 07/05/2024.
//

import SwiftUI

struct TaskModifiqued: View {
    
    @State private var num = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task(id: num) {
                print("Se ejecuta la tarea")
            }
        Button(action: {
            num += 1
        }){
            Text("Incrementar")
        }
    }
}
