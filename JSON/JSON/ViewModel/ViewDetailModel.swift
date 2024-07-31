//
//  ViewDetailModel.swift
//  JSON
//
//  Created by Joaquin Villarreal on 12/04/2024.
//

import Foundation

class ViewDetailModel: ObservableObject {
    
    @Published var first_name = ""
    @Published var email = ""
    @Published var avatar = ""
    
    func fecth(id: Int){
        guard let url = URL(string: "https://reqres.in/api/users/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) {data,_,_ in
            
            guard let data = data else { return }
            
            do{
                let json = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.first_name = json.data.first_name
                    self.avatar = json.data.avatar
                    self.email = json.data.email
                }
            } catch let error as NSError {
                print("Error en el JSON", error.localizedDescription)
            }
            
        }.resume()
    }
}
