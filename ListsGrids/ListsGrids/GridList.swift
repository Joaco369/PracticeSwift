//
//  GridList.swift
//  ListsGrids
//
//  Created by Joaquin Villarreal on 06/04/2024.
//

import SwiftUI

struct GridList: View {
    
    let gridItem: [GridItem] = Array(repeating: .init(.flexible(maximum: 300)), count: 2)
    
    var body: some View {
        NavigationView{
            ScrollView(.horizontal){
                LazyHGrid(rows: gridItem, spacing: 30) {
                    ForEach(lista){ item in
                        Text(item.emoji).font(.system(size: 80))
                    }
                }
            }.navigationTitle("Grid")
        }
    }
}

