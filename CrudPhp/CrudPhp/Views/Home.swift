//
//  Home.swift
//  CrudPhp
//
//  Created by Joaquin Villarreal on 23/05/2024.
//

import SwiftUI

struct Home: View {
    
    @StateObject var crud = Crud()
    
    var body: some View {
        NavigationView{
            List {
                ForEach(crud.posts, id:\.id){ item in
                    NavigationLink(destination: DetailView(crudItem: item)) {
                        CellView(image: item.image, title: item.title, content: item.content)
                    }
                }
            }
            .navigationTitle("CRUD")
            .listStyle(.plain)
                .toolbar{
                    NavigationLink(destination: PostView()){
                      Image(systemName: "plus")
                    }
                }.onAppear{
                    crud.getData()
                }
        }
    }
}

struct CellView: View {
    
    var image: String
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.largeTitle).bold()
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.red
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 10)
            Text(content).font(.body)
        }
    }
}
