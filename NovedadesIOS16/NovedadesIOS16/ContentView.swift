//
//  ContentView.swift
//  NovedadesIOS16
//
//  Created by Joaquin Villarreal on 26/06/2024.
//

import SwiftUI
import Charts

struct ContentView: View {
    var body: some View {
        VStack {
            Chart(datosGanancia){ item in
//                BarMark(x: .value("Day", item.day), y: .value("Ganancia", item.price))
//                    .foregroundStyle(by: .value("Day", item.day))
//                LineMark(x: .value("Day", item.day), y: .value("Ganancia", item.price))
//                    .symbol(by: .value("Day", item.day))
//                AreaMark(x: .value("Day", item.day), y: .value("Ganancia", item.price))
                
                RectangleMark(x: .value("Day", item.day), y: .value("Ganancia", item.price))
            }
        }
        .padding()
    }
}

struct Datos : Identifiable {
    
    var price: Double
    var day: String
    var id = UUID()
}

var datosGanancia: [Datos] = [
    Datos(price: 3200, day: "Monday"),
    Datos(price: 4000, day: "Tuesday"),
    Datos(price: 2000, day: "Wednesday"),
    Datos(price: 3000, day: "Thursday"),
    Datos(price: 1400, day: "Friday")
]
