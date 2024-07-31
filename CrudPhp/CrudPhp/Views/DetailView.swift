//
//  DetailView.swift
//  CrudPhp
//
//  Created by Joaquin Villarreal on 23/05/2024.
//

import SwiftUI

struct DetailView: View {
    
    var crudItem: Posts
    @StateObject var crud = Crud()
    @State private var show = false
    
    var body: some View {
        VStack(alignment: .center){
            CellView(image: crudItem.image, title: "", content: crudItem.content)
            HStack(alignment: .center){
                Button {
                    show.toggle()
                } label: {
                    Text("Edit")
                }.buttonStyle(.bordered)
                    .sheet(isPresented: $show){
                        EditView(crudItem: crudItem)
                    }
                
                Button {
                    crud.delete(id: crudItem.id, nameImage: crudItem.nameImage)
                } label: {
                    Text("Delete")
                }.buttonStyle(.bordered)
                    .tint(.red)
            }
            Spacer()
        }.padding(.all)
            .navigationTitle(crudItem.title)
            .alert(crud.message, isPresented: $crud.show) {
                Button("accept", role: .none) {}
            }
    }
}
