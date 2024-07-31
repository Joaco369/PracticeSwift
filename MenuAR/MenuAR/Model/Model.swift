//
//  Model.swift
//  MenuAR
//
//  Created by Joaquin Villarreal on 17/06/2024.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable{
    
    case meats
    case pizza
    case burgers
    case desserts
    
    var label: String {
        get {
            switch self {
            case .meats:
                return "Meats"
            case .pizza:
                return "Pizza"
            case .burgers:
                return "Burgers"
            case .desserts:
                return "Desserts"
            }
        }
    }
}

class Model {
    
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scale: Float
    
    var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scale: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scale = scale
    }
    
    func loadModel(){
        let fileName = name + ".usdz"
        print(fileName)
        cancellable = ModelEntity.loadAsync(named: fileName)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion {
                case .failure(let error):
                    print("Error loading Model", error.localizedDescription)
                case .finished:
                    print("Success")
                    break
                }
            }, receiveValue: { modelEntity in
                self.modelEntity = modelEntity as? ModelEntity
                self.modelEntity?.scale *= self.scale
            })
    }
}

struct Models {
    
    var all: [Model] = []
    
    init(){
        all = [
            Model(name: "strawberry", category: .desserts, scale: 3/100),
            Model(name: "vanilla", category: .desserts, scale: 3/100),
            Model(name: "raspberry", category: .desserts, scale: 3/100),
            Model(name: "cherry", category: .desserts, scale: 3/100),
            Model(name: "meat", category: .meats, scale: 3/100),
            Model(name: "chick", category: .meats, scale: 3/100),
            Model(name: "pizza", category: .pizza, scale: 3/100),
            Model(name: "burger", category: .burgers, scale: 3/100)
        ]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category} )
    }
}
