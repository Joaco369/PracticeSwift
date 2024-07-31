//
//  ContentView.swift
//  TextCombine
//
//  Created by Joaquin Villarreal on 08/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cont = Model()
    
    var body: some View {
        VStack {
            Text("Contador = \(cont.cont)")
            Button("Reiniciar"){
                cont.cont += 1
            }
            Spacer()
            view2()
            Spacer()
            view3()
            Spacer()
            view4()
            Spacer()
            view5()
            Spacer()
        }
        .padding()
    }
}

struct view2: View {
    
    @ObservedObject var cont = Model()
    
    var body: some View {
        VStack {
            Text("Contador View2 (Observed Object) = \(cont.cont)")
            Button("Sumar Contador"){
                cont.cont += 1
            }
        }
        .padding()
    }
}
struct view3: View {
    
    @StateObject var cont = Model()
    
    var body: some View {
        VStack {
            Text("Contador View3 (State Object) = \(cont.cont)")
            Button("Sumar Contador"){
                cont.cont += 1
            }
        }
        .padding()
    }
}
struct view4: View {
    
    @EnvironmentObject var cont: Model
    
    var body: some View {
        VStack {
            Text("Contador View4 (EnviromentObject) = \(cont.cont)")
            Button("Sumar Contador"){
                cont.cont += 1
            }
        }
        .padding()
    }
}
struct view5: View {
    
    @EnvironmentObject var cont: Model
    
    var body: some View {
        VStack {
            Text("Contador View5 (EnviromentObject) = \(cont.cont)")
            Button("Sumar Contador"){
                cont.cont += 1
            }
        }
        .padding()
    }
}
