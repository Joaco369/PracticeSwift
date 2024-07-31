//
//  ModelViewModel.swift
//  JSONUIKit
//
//  Created by Joaquin Villarreal on 12/04/2024.
//

import Foundation

class ModelViewModel {
    
    public static var shared = ModelViewModel()
    
    var datosModel = Modelo(data: [])
    
    func fetch(completion: @escaping (_ done: Bool) -> Void){
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return }
        
        URLSession.shared.dataTask(with: url) {data,_,_ in
            
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode(Modelo.self, from: data)
                DispatchQueue.main.async {
                    self.datosModel = json
                    completion(true)
                }
                
            } catch let error as NSError{
                print("Error", error.localizedDescription)
            }
            
        }.resume()
    }
}
