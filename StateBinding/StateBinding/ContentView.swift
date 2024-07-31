//
//  ContentView.swift
//  StateBinding
//
//  Created by Joaquin Villarreal on 07/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    //Binding: Es la conexion entre una propiedad que almacena datos(variabe) y una vista que cambia de valor(TextField) El textField cambiaria el dato de la variable para luego mostrarlo.
    
    @State private var x = "Me gusta"
    @State private var numero = 0
    @State private var show = true
    @State private var moneda = 123
    @State private var moneda2 = "0"
    
    func suma() -> Int {
        x = "Cambiando su valor por default" // Se crea desde fuera, se usa el State
        var x1 = 2 // Se crea dentro de la funcion no se usa el State
        x1 = 4
        return x1
    }
    
    var body: some View {
        VStack {
            Text(x).font(.largeTitle)
            HStack {
                Button(action: {
                    show.toggle()
                    if show{
                        numero -= 1
                    } else {
                        numero += 1
                    }
                }) {
                    if show {
                        Image(systemName: "heart").foregroundColor(.red).font(.largeTitle)
                    } else {
                        Image(systemName: "heart.fill").foregroundColor(.red).font(.largeTitle)
                    }
                    Text(String(numero)).bold().foregroundColor(.black)
                }
                Button(action: {
                    moneda = moneda + Int(moneda2)!
                }){
                    Image(systemName: "dollarsign.circle.fill").foregroundColor(.yellow).font(.largeTitle)
                }
                Text(String(moneda)).bold()
            }
            TextField("Donacion", text: $moneda2)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Titulo", text: $x)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            view2(x: $x)
            view3(x: $x)
            
        }.padding(.all)
    }
}

struct view2: View {
    @Binding var x: String
    
    var body: some View{
        Text(x).font(.largeTitle).foregroundStyle(.green)
    }
}

struct view3: View {
    @Binding var x: String
    
    var body: some View{
        Button(action: {
            x = "Nuevo titulo desde view3"
        }){
            Text("Cambiar Titulo")
        }
    }
}
#Preview {
    ContentView()
}
