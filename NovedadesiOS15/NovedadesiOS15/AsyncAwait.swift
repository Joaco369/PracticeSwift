//
//  AsyncAwait.swift
//  NovedadesiOS15
//
//  Created by Joaquin Villarreal on 07/05/2024.
//

import SwiftUI

struct Data: Decodable, Identifiable{
    var id: Int
    var name: String
    var username: String
}

struct AsyncAwait: View {
    
    @State private var datos = [Data(id: 0, name: "Joaquin", username: "Joaco")]
    
    @StateObject private var datosModel = RecargarModel()
    
    @State private var searched = ""
    
    var body: some View {
        NavigationView{
            List{
                ForEach(datosModel.datosModel.filter{searched.isEmpty ? true : $0.name.contains(searched)}){ item in
                    VStack(alignment: .leading){
                        Text(item.name).font(.headline)
                        Text(item.username).font(.subheadline)
                    }.swipeActions{
                        Button("Acept"){
                            print("Acept")
                        }.tint(.blue)
                        
                        Button{
                            print("Delete")
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                                .tint(.red)
                        }
                    }
                }
            }.navigationTitle("List")
                .searchable(text: $searched)
                .task {
                    await datosModel.fetch()
                }
        }
    }
}
