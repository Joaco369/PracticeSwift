//
//  Model2ViewModel.swift
//  JSON
//
//  Created by Joaquin Villarreal on 12/04/2024.
//

import Foundation

class Model2ViewModel: ObservableObject{
    
    @Published var datosModelo = Model2(data: [])
    
    init() {
        fecth()
    }
    
    func fecth(){
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return }
        
        URLSession.shared.dataTask(with: url) {data,_,_ in
            
            guard let data = data else { return }
            
            do{
                let json = try JSONDecoder().decode(Model2.self, from: data)
                DispatchQueue.main.async {
                    self.datosModelo = json
                }
            } catch let error as NSError {
                print("Error in the JSON", error.localizedDescription)
            }
            
        }.resume()
    }
}
