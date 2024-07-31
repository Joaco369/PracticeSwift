//
//  ImageViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 17/04/2024.
//

import Foundation
import Firebase
import FirebaseStorage

class ImageViewModel: ObservableObject {
    @Published var data: Data? = nil
    
    init (imageUrl: String){
        let storageImage = Storage.storage().reference(forURL: imageUrl)
        storageImage.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error?.localizedDescription {
                print("Error al traer la imagen", error)
            }else{
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
}
