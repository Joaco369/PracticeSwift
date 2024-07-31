//
//  Navegacion.swift
//  NovedadesIOS16
//
//  Created by Joaquin Villarreal on 01/07/2024.
//

import SwiftUI

struct Navegacion: View {
    
    @EnvironmentObject private var state: returnRoot
    
    var body: some View {
        NavigationStack(path: $state.path) {
            Text("First View")
                .navigationTitle("First View")
            
            NavigationLink("Second View", value: "Hii!")
                .navigationDestination(for: String.self) { value in
                        SecondView(text: value)
                }
            NavigationLink("Tercer View", value: "How are you?")
                .navigationDestination(for: String.self) { item in
                    Text("Tercer View \(item)")
                }
            
            List(nombres){ item in
                NavigationLink(item.name, value: item)
                    .navigationDestination(for: DatosNombres.self) { val in
                        Text(val.name).font(.title)
                    }
            }
        }
    }
}

struct DatosNombres: Hashable, Identifiable{
    
    var name: String
    var id = UUID()
}

var nombres: [DatosNombres] = [
    DatosNombres(name: "Laura"),
    DatosNombres(name: "Abel"),
    DatosNombres(name: "Sandra")
]

class returnRoot: ObservableObject {
    @Published var path = NavigationPath()
    
    func goRoot(){
        path.removeLast(path.count)
    }
}
