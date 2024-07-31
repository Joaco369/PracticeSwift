//
//  ListView.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 18/04/2024.
//

import SwiftUI

struct ListView: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    func getColumns() -> Int {
        return (device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3: 1)
    }
    
    var plataform : String
    @StateObject var data = FirebaseViewModel()
    //@State private var showEdit = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20){
                ForEach(data.data) { item in
                    CardView(title: item.title, image: item.image, index: item, plataform: plataform)
                        .onTapGesture {
                            data.sendData(item: item)
                        }.sheet(isPresented: $data.showEdit, content: {
                            EditView(plataform: plataform, datos: data.itemUpdate)
                        })
                        .padding(.all)
                }
             }
        }.onAppear{
            data.getData(plataform: plataform)
        }
    }
}

