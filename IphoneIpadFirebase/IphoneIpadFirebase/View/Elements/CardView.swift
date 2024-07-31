//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 14/04/2024.
//

import SwiftUI

struct CardView: View {
    
    var title : String
    var image: String
    
    var index: FireBaseModel
    var plataform : String
    
    @StateObject var datos = FirebaseViewModel()

    var body: some View {
        VStack(spacing: 20){
            ImageFirebase(imageUrl: image)
            Text(title)
                .font(.title).bold().foregroundColor(.black)
            Button(action: {
                datos.delete(index: index, plataform: plataform)
            }){
                Text("Delete")
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Capsule().stroke(Color.red))
            }
        }.padding()
            .background(Color.white)
            .cornerRadius(20)
    }
}
