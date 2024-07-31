//
//  Setting.swift
//  MenuAR
//
//  Created by Joaquin Villarreal on 18/06/2024.
//

import SwiftUI
import Combine

class Setting: ObservableObject{
    
    @Published var selectedModel: Model? {
        willSet(newValue){
            print("We selected the model")
        }
    }
    
    @Published var confirmedModel: Model? {
        willSet(newValue){
            guard let model = newValue else { return }
            print("We confirm the model", model.name)
        }
    }
    
    var sceneObserver: Cancellable? 
    
}
