//
//  ContentView.swift
//  ListsGrids
//
//  Created by Joaquin Villarreal on 06/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            List(lista){ item in
                NavigationLink(
                    destination: ViewDetail(items: item)){
                        HStack{
                            emoji(emoji: item)
                            Text(item.nombre)
                                .font(.subheadline)
                            
                        } .navigationTitle("List")
                    }
            }
        }
    }
    struct emoji: View {
        let emoji: Model
        
        var body: some View{
            ZStack{
                Text(emoji.emoji)
                    .shadow(radius: 10)
                    .font(.title)
                    .frame(width: 65, height: 65)
                    .overlay(Circle().stroke(Color.purple, lineWidth: 3))
            }
        }
    }
    
    
    struct ViewDetail: View {
        
        let items: Model
        
        var body: some View {
            
            VStack(alignment: .leading, spacing: 3, content: {
                HStack{
                    emoji(emoji: items)
                    Text(items.nombre)
                        .font(.largeTitle)
                    Spacer()
                }
                
                Text(items.description).padding(.top)
                Spacer()
            })
            
            .padding(.all)
            .navigationTitle("Emojis")
        }
    }
}
