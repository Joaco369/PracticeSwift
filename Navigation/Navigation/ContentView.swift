//
//  ContentView.swift
//  Navigation
//
//  Created by Joaquin Villarreal on 04/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var show = false
    @State private var texto = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Texto", text: $texto)
                NavigationLink(destination: SecondView(texto: texto)){
                    Text("SecondView")
                }
                Button("Open ViewModel"){
                    show.toggle()
                }
                .sheet(isPresented: $show) {
                    _ViewModel(texto: texto)
                }.navigationTitle("Navigation")
                    .toolbar{
                        NavigationLink(destination: SecondView(texto: texto)){
                            Image(systemName: "plus")
                        }
                        NavigationLink(destination: TercerView()){
                            Image(systemName: "camera")
                        }
                 }
            }
        }.padding(.all)
    }
}

#Preview {
    ContentView()
}
