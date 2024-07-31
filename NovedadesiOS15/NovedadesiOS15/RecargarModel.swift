//
//  RecargarModel.swift
//  NovedadesiOS15
//
//  Created by Joaquin Villarreal on 07/05/2024.
//

import Foundation

@MainActor
class RecargarModel: ObservableObject{
    
    @Published var datosModel: [Data] = []
    
    func fetch() async{
        do {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let datos = try JSONDecoder().decode([Data].self, from: data)
            self.datosModel = datos
        } catch let error as NSError {
            print("Error", error.localizedDescription)
        }
    }
}
