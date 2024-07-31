//
//  Home.swift
//  MyNotes
//
//  Created by Joaquin Villarreal on 09/04/2024.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "fecha <= %@", Date() as CVarArg), animation: .spring) var results : FetchedResults<Notas>
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(results){ item in
                    VStack(alignment: .leading) {
                        Text(item.nota ?? "No hay nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            model.sendData(item: item)
                        }){
                            Label(
                                title: { Text("Editar") },
                                icon: { Image(systemName: "pencil") }
                            )
                        }
                        Button(action: {
                            model.deleteData(item: item, context: context)
                        }){
                            Label(
                                title: { Text("Eliminar") },
                                icon: { Image(systemName: "trash") }
                            )
                        }
                        
                        
                    }))
                }
            }.navigationTitle("Notes")
                .navigationBarItems(trailing:
                                        Button(action: {
                    model.show.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                )
        }.sheet(isPresented: $model.show, content: {
            AddView(model: model)
        })
    }
}
